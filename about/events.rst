.. digraph:: events

   splines=ortho
   node [shape=plaintext];

    past
    -> 2014.10
    -> 2015.10
    -> 2016.01
    -> 2016.04
    -> 2016.08
    -> 2016.10
    -> 2017.01
    -> 2017.06
    -> 2017.00
    -> 2018.09
    -> 2019.03
    -> 2019.04
    -> 2019.08
    -> 2019.10
    -> 2020.02
    -> 2020.06
    -> future [style=invis];

    {rank=same past}

    {rank=same 2014.10 start_os67[label="Start writing OS67"]}

    {rank=same 2015.10 end_os67[label="OS67 0.01 released"]}
    start_os67 -> end_os67;

    {rank=same 2016.01 start_srain[label="Start writing Srain"]}

    {rank=same 2016.04 start_gsoc2016[label="Get selected for GSoC"]}

    {rank=same 2016.08 end_gsoc2016[label="Finish my summer of code"]}
    start_gsoc2016 -> end_gsoc2016;

    {rank=same 2016.10 intern_chaitin[label="Internship at Chaitin Tech, Inc."]}

    {rank=same 2017.01 learn_watercolor_jgr[label="Learn classical watercolor from 纪盖荣"]}

    {rank=same 2017.06 graduate_scau[label="Graduated from SCAU"]}

    {rank=same 2017.06 join_chaitin [label="Join Chaitin Tech as FTE"]}
    intern_chaitin -> join_chaitin;

    {rank=same 2017.00 learn_swimming[label="Learn breaststroke"]}

    {rank=same 2018.09 learn_badminton[label="Learn badminton!"]}
    learn_swimming -> learn_badminton;

    {rank=same 2019.03 injure_knee[label="My knee injured because of badminton :'("]}
    learn_badminton -> injure_knee;

    {rank=same 2019.04 sketch_beidaihe[label="Go to 北戴河 alone for sketching"]}
    learn_watercolor_jgr -> sketch_beidaihe;

    {rank=same 2019.08 learn_watercolor_taylor[label="Learn landscape watercolor from David Taylor"]}
    sketch_beidaihe -> learn_watercolor_taylor;

    {rank=same 2019.10 learn_guitar[label="Start learning guitar"]}

    {rank=same 2020.02 announce_srain[label="Announcing Srain 1.0"]}
    start_srain -> announce_srain;

    {rank=same 2020.06 quit_chaitin[label="Quit from Chaitin Tech"]}
    join_chaitin -> quit_chaitin;

    {rank=same future}
