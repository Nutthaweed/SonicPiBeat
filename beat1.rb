use_bpm 145

pl = [chord(:c3 , "major7"),
      chord(:e3 , "major7"),
      chord(:d3 , "major7"),
      chord(:db3 , "major7")]

with_fx :reverb do
  with_synth :piano do
    live_loop :piano do
      pl.each {
        |c|
        play c ,decay: 2.5 ,amp: 1
        play c+12 ,decay: 2.5 ,amp: 4
        sleep 3
        play c.choose+24,decay: 2.5,amp: 2
        sleep 1
        play c.choose+12,decay: 2.5,amp: 3
        sleep 2
      }
    end
  end
end

with_fx :reverb do
  with_fx :bitcrusher do
    with_synth :dull_bell do
      live_loop :bells do
        vs = [1,1,1,0, 1,0,1,0, 1,0,0,0, 0,0,0,1].ring
        play vs.choose+24, amp: 0.5*vs.tick(:vs)
        sleep 0.5
      end
    end
  end
end

def kick(v)
  sample :bd_mehackit ,amp: 2*v
end

live_loop :kick1 do
  kick(1)
  sleep 5
  kick(1)
  sleep 3
end

live_loop :kick2 do
  v=[0,0,0,1].choose
  kick(v)
  sleep 7
end

def snare(v)
  sample :sn_generic , rate: 2 , amp: 2*v ,attack: 0,sustain: 0,release: 0 ,decay: 0.08
  sample :drum_snare_hard ,rate: 2 ,amp: 2*v,attack: 0.1,sustain: 0,release: 0 ,decay: 0.08
end

live_loop :snare do
  vs = [0,0,0,1, 0,0,0,1, 0,0,0,1, 0,0,1,1]
  vs.each {
    |v|
    snare(v)
    sleep 1
  }
end

def hat(v)
  sample :drum_cymbal_closed , amp: v ,attack: 0,sustain: 0,release: 0 ,decay: 0.01
end

live_loop :hat do
  a=[0,1].choose
  case a
  when 0
    8.times do
      hat(1)
      sleep 0.5
    end
  when 1
    8.times do
      hat(1)
      sleep 0.25
    end
  end
end

