Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D2C7EF09
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jul 2024 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782920; cv=none; b=EHUvfw25jrf5l6zkbYZX2rjL30kR4J97iglffoEaTYQLnqo5s1iOu2aee5C/e6Aa8o9QBCiR8/VLNrzhB6mOhRIfJ26+lRw7z8JK77QUSEDFpinohW5ne0kdroI3jC2vNHPqJUR6BitlPX5j0VOIEUROHgcbRFbMekVeCNV1+uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782920; c=relaxed/simple;
	bh=pmlYIYX68+yFXZvft3w9PXa8LuoH+LCDww0NFTljR/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9HFlWqtqF020m1l6MT7WqwWsGR02hPWteQd/gsESqH04wlL8QBqRPHQFaKDlbXSmVo7OWIkT2qfDmAGu9LRmTX5DB/Fas48/2djTOUnN2WnNlJeq80Yh9WaJ1n4eoSYxGz4qp33Uo9/tmpA4l5ZqxidgwTl9rLbW8zP9OA/LSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WL89N0y04z6K5xG;
	Fri, 12 Jul 2024 19:13:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E18C5140CB1;
	Fri, 12 Jul 2024 19:15:15 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 12:15:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
	<anisinha@redhat.com>
Subject: [PATCH v5 13/13] bios-tables-test: Add data for complex numa test (GI, GP etc)
Date: Fri, 12 Jul 2024 12:08:17 +0100
Message-ID: <20240712110837.1439736-14-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Given this is a new configuration, there are affects on APIC, CEDT
and DSDT, but the key elements are in SRAT (plus related data in
HMAT).  The configuration has node to exercise many different combinations.

0) CPUs + Memory
1) GI only
2) GP only
3) CPUS only
4) Memory only
5) CPUs + HP memory

GI node, GP Node, Memory only node, hotplug memory
only node, latency and bandwidth such that in Linux Access0
(any initiator) and Access1 (CPU initiators only) given different
answers.  Following cropped to remove details of each entry.

[000h 0000 004h]                   Signature : "SRAT"    [System Resource Affinity Table]
...
[030h 0048 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
...
[032h 0050 001h]     Proximity Domain Low(8) : 00
[033h 0051 001h]                     Apic ID : 00
...
[040h 0064 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
...
[042h 0066 001h]     Proximity Domain Low(8) : 03
[043h 0067 001h]                     Apic ID : 01
...
[050h 0080 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
...
[052h 0082 001h]     Proximity Domain Low(8) : 05
[053h 0083 001h]                     Apic ID : 02
...
[060h 0096 001h]               Subtable Type : 01 [Memory Affinity]
...
[062h 0098 004h]            Proximity Domain : 00000000
...
[068h 0104 008h]                Base Address : 0000000000000000
[070h 0112 008h]              Address Length : 00000000000A0000
...
[088h 0136 001h]               Subtable Type : 01 [Memory Affinity]
...
[08Ah 0138 004h]            Proximity Domain : 00000000
...
[090h 0144 008h]                Base Address : 0000000000100000
[098h 0152 008h]              Address Length : 0000000003F00000
...
[0B0h 0176 001h]               Subtable Type : 01 [Memory Affinity]
...
[0B2h 0178 004h]            Proximity Domain : 00000004
...
[0B8h 0184 008h]                Base Address : 0000000004000000
[0C0h 0192 008h]              Address Length : 0000000004000000
... some zero length entries follow...

[1A0h 0416 001h]               Subtable Type : 05 [Generic Initiator Affinity]
[1A1h 0417 001h]                      Length : 20

[1A2h 0418 001h]                   Reserved1 : 00
[1A3h 0419 001h]          Device Handle Type : 01
[1A4h 0420 004h]            Proximity Domain : 00000001
[1A8h 0424 010h]               Device Handle : 00 00 01 02 00 00 00 00 00 00 00 00 00 00 00 00
[1B8h 0440 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
                  Architectural Transactions : 0
[1BCh 0444 004h]                   Reserved2 : 00000000

[1C0h 0448 001h]               Subtable Type : 06 [Generic Port Affinity]
[1C1h 0449 001h]                      Length : 20

[1C2h 0450 001h]                   Reserved1 : 00
[1C3h 0451 001h]          Device Handle Type : 00
[1C4h 0452 004h]            Proximity Domain : 00000002
[1C8h 0456 010h]               Device Handle : 41 43 50 49 30 30 31 36 40 00 00 00 00 00 00 00
[1D8h 0472 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
                  Architectural Transactions : 0
[1DCh 0476 004h]                   Reserved2 : 00000000

[1E0h 0480 001h]               Subtable Type : 01 [Memory Affinity]
...
[1E2h 0482 004h]            Proximity Domain : 00000005
...
[1E8h 0488 008h]                Base Address : 0000000100000000
[1F0h 0496 008h]              Address Length : 0000000090000000

Example block from HMAT:
[0F0h 0240 002h]              Structure Type : 0001 [System Locality Latency and Bandwidth Information]
[0F2h 0242 002h]                    Reserved : 0000
[0F4h 0244 004h]                      Length : 00000078
[0F8h 0248 001h]       Flags (decoded below) : 00
                            Memory Hierarchy : 0
                   Use Minimum Transfer Size : 0
                    Non-sequential Transfers : 0
[0F9h 0249 001h]                   Data Type : 03
[0FAh 0250 001h]       Minimum Transfer Size : 00
[0FBh 0251 001h]                   Reserved1 : 00
[0FCh 0252 004h] Initiator Proximity Domains # : 00000004
[100h 0256 004h]  Target Proximity Domains # : 00000006
[104h 0260 004h]                   Reserved2 : 00000000
[108h 0264 008h]             Entry Base Unit : 0000000000000004
[110h 0272 004h] Initiator Proximity Domain List : 00000000
[114h 0276 004h] Initiator Proximity Domain List : 00000001
[118h 0280 004h] Initiator Proximity Domain List : 00000003
[11Ch 0284 004h] Initiator Proximity Domain List : 00000005
[120h 0288 004h] Target Proximity Domain List : 00000000
[124h 0292 004h] Target Proximity Domain List : 00000001
[128h 0296 004h] Target Proximity Domain List : 00000002
[12Ch 0300 004h] Target Proximity Domain List : 00000003
[130h 0304 004h] Target Proximity Domain List : 00000004
[134h 0308 004h] Target Proximity Domain List : 00000005
[138h 0312 002h]                       Entry : 00C8
[13Ah 0314 002h]                       Entry : 0000
[13Ch 0316 002h]                       Entry : 0032
[13Eh 0318 002h]                       Entry : 0000
[140h 0320 002h]                       Entry : 0032
[142h 0322 002h]                       Entry : 0064
[144h 0324 002h]                       Entry : 0019
[146h 0326 002h]                       Entry : 0000
[148h 0328 002h]                       Entry : 0064
[14Ah 0330 002h]                       Entry : 0000
[14Ch 0332 002h]                       Entry : 00C8
[14Eh 0334 002h]                       Entry : 0019
[150h 0336 002h]                       Entry : 0064
[152h 0338 002h]                       Entry : 0000
[154h 0340 002h]                       Entry : 0032
[156h 0342 002h]                       Entry : 0000
[158h 0344 002h]                       Entry : 0032
[15Ah 0346 002h]                       Entry : 0064
[15Ch 0348 002h]                       Entry : 0064
[15Eh 0350 002h]                       Entry : 0000
[160h 0352 002h]                       Entry : 0032
[162h 0354 002h]                       Entry : 0000
[164h 0356 002h]                       Entry : 0032
[166h 0358 002h]                       Entry : 00C8

Note the zeros represent entries where the target node has no
memory.  These could be surpressed but it isn't 'wrong' to provide
them and it is (probably) permissible under ACPI to hotplug memory
into these nodes later.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v5: No change
---
 tests/qtest/bios-tables-test-allowed-diff.h     |   5 -----
 tests/data/acpi/x86/q35/APIC.acpihmat-generic-x | Bin 0 -> 136 bytes
 tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x | Bin 0 -> 68 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 0 -> 10849 bytes
 tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x | Bin 0 -> 360 bytes
 tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x | Bin 0 -> 520 bytes
 6 files changed, 5 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 3c0967078f..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,6 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/q35/APIC.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x",
diff --git a/tests/data/acpi/x86/q35/APIC.acpihmat-generic-x b/tests/data/acpi/x86/q35/APIC.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..317ddb3fbed94e4f49a87976fdc7f23b1a6c3fdc 100644
GIT binary patch
literal 136
zcmZ<^@O18AU|?WQaPoKd2v%^42yj*a0!E-1hz+6{7#{os(;N&85Soz@LNhUeXht58
ongjnpBoh}9gBTzdD=U!Z1+h3eVJt470*DwlH<-o3_8({j09efo0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..31c9011663639b4a0f4816f3b2b06398f94682f7 100644
GIT binary patch
literal 68
zcmZ>EbqR4{U|?Xhb@F%i2v%^42yj*a0!E-1hz+6{7!(*BfFy(s;xkNuupuM>Q<et-

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..75e926a25b819889977355a6a2dd8e0209487ad4 100644
GIT binary patch
literal 10849
zcmcIqUu+x6d7t4QX|-HQD{3wKd_J4--KCdHdPm8BF8!09$z6)1&6Q}9^0}Z<E+x5@
z>=d{4os07s24o#@ar}_>j&abw(FZ2&Tl-M-Er@~Sp?xz@6g{9ofjsmjj}3~rKoRx#
z&Fs=MBn8AkY6H}Kv)}Lg<~KV#zuDRGnqI5>CS&|(#dWvR%oVTJ-5maL#u%09uU$=D
zW9>b!SnlvlBE{SHGop;2qTzhqD{hqeU+o0n4}uTB9q?|*HoveRZFa*?9t4|=oNjN1
zrbz|+(qgAs?6mi*^L4kHH#(K7XBD2BhS70lDQR>zsvdJ{)1CFEn|gSYx!!xr{k3#&
zXJOH_+y1|w`Q@n-7ry`AhlMBK{I@@Tc+*V5VFiB;{5=!WPjELdPX>Ma^WHAMM{sd%
zxxe^%Ph6IDHeCq=s(Eb5DhjncxanL<m%OGw+dtpC!NP?kXF>n?=duA$-}&eNY@Ykr
z|Lo|`{g-~?`h%c9{b<)r41&<S{~%xt6(@Q(%;_+jPOw=PpclTySU2p-i|zeyc#VQ9
zn9tVN>UlT6%)q|UTsUQ(`1Vo8Eb4Ol_xA?}2S1iYX5V3U&3TJDk2<csS9hB&o_S)K
zM*F@^hKu@*9Dcl9d#_o#h+FkfmYKr6BEv1_OBZpWxaK!_=Bb2{;TG36{9L{2UCp(5
zvF2W4&g*rzbTQF>m8^q<aECm?JA9W>jP`F)^?*5FD*!Xei(-ZJ6GXm&Q=F-b{`96^
zs6)|fltgqOemL92ZMfIlWW7xbeRII>b$Rz*_YOCwpLcNob*=YD0)(6LHW>A)yUHA^
zgTFl7A<N#s!l{34_vd14)*G#Q_R<G?*-R>fT(z}JB__)p<yDrosNPJ#D91(;MulZ(
zQ)nM<qx6d`LcwuPUK2RD#wH;VU-%{j626f|$k;W(1QM<S36qd$jqpthWZZ%zBV_EF
zlt{P=BuqlaSyBQSw;&~uv1>{q<Ho~Od8Rd<X@QJg(-Ijs9;V83O5-^tkg@BO&J(7}
zb6Vp$t?``JdBRkA8X8YS<7wzTVX8c5G@dgW&l#O3OqHjp@iaA_rp^<l$}^+!%xF9_
zI!~A?PfO!zX*?~RCrp*+tj2Rz<2kGIgsJkJ(|FElJm++tFjb!O8qax+=e*7nrpnXS
zc-k6ITjvQ=<+-5oT+nzf=saPnJhK|ltj05|^MtALT-10jYCIQpo-kFOj>gl`cse>y
zm@3aB8qXsd&m%fdm@3aDjpvfab4lk3Q{@R6lXI4sm5ypWkLo;OsyvTrJdbHSkLf&N
zsyts3$U-y|z9f*vXtH}rBHiaEA-%}=xQ0BgA&=`wm@4vR4f(Q$d|5}rRFNk%<OvOV
zLPx?>k*{dTS2W}+IufReJSmXz9Dh<E<2nAMM8*?0OhU#=a!Sj2O3Qgl&k0lJG$5b_
zML^5VDpCtE<tQU@B%m;mRvJkdaZ(7V^b>=KGeX7f<47u9hXM*SrUn6(zOjHRt|Xw+
zbts@P(VAF5rEg?WPDG6rlaO(bk$}QPi-a!(RQg6%#8DtgK&5MJsyrc}GOR#CKowUK
zP?)hQl7PaDc|t&?uRuaT6;~2a=_+!PfWnM<LO`XjKtezjR}xU^Dv%_gFk_w&Q0Xg>
z5KzUH1XQ{TBnc?Y_<lk_rLRCjKowUKQ0Xd=B%m;3o)A#!E07RS#gzn9x(Xx-D9o5A
z1XTJ8Bm`7(B>|PL0!ac2Gv)~amA(QA0aaW{K&7idl7PaDc|t&?uRuaT6;~2a=_-&U
zpfF>e5K!qWkPuMCl>}6}3M2_A%$O$xRQd`e1XOV)0hO)-NdgKp<_Q6nz5)pWRa{9x
zrK>=afWnM<LO`XjKtezjR}xU^Dv%_gFk_w&Q0Xg>5KzUH1XQ{TBnc?Ym?s2O`U)fj
zRB<H%m97Fw0tz$c2?3S90to?CTuDHst3Z-~!i;%BK&7uhLO>N)5>V+XkR+fmW1bLD
z=_`;BP{ox5RJsZz2`J2%Cj?ab3M2$naU}tjt^!E{3Nz*j0hPW22?14HNkFBmK$3vM
zjCn#pVJQL%OBGO<s(`{&1XMvnKoukjsDdN`Rge%+1qlIFkR+fAk_1#iLO>NH1XMwi
zfGS85Pz4DARge%+1xW&`AW1+KBm@*ze0L$BuyDsjXOe)z#BGR8LdJay0fiO!Ed&%+
z+_xm4Fyp=@0fmV@kmDUlDC=82@v=Ig7t+U5^rzq~RxjiIzdv)=+}mLTb7o*>oU_%-
zZes?r+sH4>nVIiQu^F+IaECplIx~&mYIt|YoM%)*phmvEUz>)`7vh~5YhLcZ7)ae*
zSTYyCGsk9<P$-5um|-?$cbGHZX|@V%KuxGOE*G4Ij#q86dsH^}M9n;HXpo275cbhd
zv(e-accL~>da94I7e})57sy^zvKK}6BHE{BFFKR67u)+jahH2B*oBI?n~4`l?<(nC
zk=`9i?;eugjnaD~<W1~={n~x+Dd|0t-Wy5p9g^OQ(w9clr(Pg^Nl9N4=}RN&ONXQ{
zMd?>Z)2Ck`{i>3FRis}XNxynX`qe0Xc{Kgh3#2bA>B}O0c_e-Lko4s!ePuNL^b4e~
zDCsLAePtwl<&g9hq)*XwG@9O)>Ep=*O9MRaa&uCzbEd>2k3aNWN8v^vV{<_dhxNi(
zI9WF_+}LxO)x%*CF&0kNO$;~ooGt3%u(B8nC+jAL8+&dXJsg%BW8q}o#BgKJ!4W+i
z)*xfyWZlGYW8->B4~K=xSU6cXG2GZVJ*tPpYGo{(tkc8Uz9F~&OGc$$YQ@8kW6GmV
z|Mp&`-trk%-cNs(Vc5F1$zHrtTJv)ChS$kC=Y{fwR1<_$)%`dy?VxXc)(coKz<%t2
z_2)k8b=mj27W>(Mrw0&6NE&UgFPL+m;uVB~GrX)}L*40=>+(L%7TkI@pU<CXcI~2U
zV#U1nb~4^?uQy7~xV0wc2()(At#9Ni?|&G6>-L}IZe9Q2{oA*;u7AMV+^yFxMGwua
zX_ony)|VEy?tmSpb?n)HX_;30{u^WzSkA4N*0@_;YjU^YU*Xt!&(qH;XGz!fJ?!ph
z$usFTOSK%_y+SL8ZR_e<)d(3?w)Zc-drf>8K!ao>BR0!<YKHu*l6Ky3TdRMV=$pMA
z_Nfc1yHw;<T;A<xdOK!<$}780WeQ&t3N!6juf3g8`4cbt957mqHiYznq&Iqjn1$v%
zJ_C$hsa+Zbj-MvBFP4aphC+mi@tyLL+jQ5ALueT8TIs!P;vi&OA>aO@l<jTvkZp%N
z2wC?F-}=j5z#nayNiYkyMso_rqm{T>{iBaYYjL}_e$b!kb<G3h`9V18djGYtuA}h~
zZattzcG>MNn)Udd{<$$XF=B9Asi9*%gNwl3-lETOrIh?0M*%n477c|hBxo;BCN~xf
z?YX@<xu5+RcfHxN4(aE~!(}W!IxpOv&^Mu(7_BAO8>5xz=83IqfAR-3*6FEd^tA^A
z+ZfRB#*^U}S_>J|VA#;0WwJAe500%2kzqT#H!#6n^;!FqT8f?!v5wXPV2wHqz_|#J
z=|m52o-4t49L!9%KUt?}E7+c*gtO0^Lu<}qxI{vPvxec!1cW_qoS7H~Ogk^*$;TYl
zDdksKG+ogwKqDWboK|KqzfzY9C_XwCFw@Cd%)kDp@87zU+Zmh4<fJKPFs%Jec8q4Q
zN}WC*GSfWP-Y=Bow1db}sz)MwRo~BTU;p!6nidV;TWgq!_Wie%TSsl8h)KUutmW`i
z!B34!HI(XCJGu7#uTStVunVSNYIe9!&xub@flnVi+xK6a;GOho>h#x3SMbwxa}GX1
zV*ucxq&6{9h)kRN;?rkg%175J*YNzeU!`jY2VeaDqks@$Kmq%UJ((SkQouvel*dbb
zrze|3we(Pubt~YQ11ZRWJHPFd2q<C0zusXYV5TQH$r)342TtLb59z`bDVq@c8h+#a
z*@ZJ^{^8f~y%-<;^nbsikE8e(*GlW)055_BH0RLrnk;5ftjOY5YNfdLO%$WrCBJYr
z@;#1XC8XO#AS%=-5DK*l0jN-;Ah)QR3WOy?Tqbnic|>(|{TA6=R4#~0{^78ON;SGx
z>wD8Zs>T3noLL!uA|FyFszj403VLT&OcUWd;Dq8Fuu*Xd4eErHnJ$MEoGymcPP!D`
zA%YEy=g&H?VI2B=^ag}9I^&xfIB#HJwNhhFyEN#+8#L-<Nar-hX&xWV_1lSIg5fJ&
z@YqiI^*oM7&>AEE5hkyA;bHB?>w6j$bR9Mg<pGVU$fj9qKy4QG0!<r9Y8{!FIDnu@
zikcy6qIAo{baWU&9?JOtNavjJ@nl4+5TY5aLQq`ZRc5m@@oYwu3q6wd`pIi@UAB7C
zt(}$KV_q;i#o`+ML6hTE56x^?^<=GtI9WnJNu#+@uQS7KHEN8?t|+@WW<s;Ra?At^
z$%*GoWNqeO|7&OWrw{!fee-+A?RWp>e-Ax<a_ZMSeS-5QE7UY`Y=v4U&!hCc)S(G2
zV9p{j9bY*|xU<BE3g-~OrGqTzIQ<N6KAzK$wOp7H8%kj|u_u-}YtxUq=3e-5*G#a@
z@b0bdCbpi~R^RSzu`oL$j|6yZn=1IQqJWBp-j<md))b?f<gmuYQtIBFP19yrlCuZf
zjD>f*i2Y!jvvB)CK#Q6|ASLFAnSC(J5?J-K3;0iJjJ5fCTHfw*+Qoya-QahaGb6`6
zHoe~I;ADx_&&&S$;s0F!#ee+GpI!LjjeoE*>)&l)lE1+QIKjjFbG;jUkTnuKn@TWl
z`$wdDiK8Ck{orE8{KvQ<jJ+$GQ|8aCXBIb5&*eP(OSJQuHMD2N^z#dGZYP?QOiV_!
zQAYm~OgqtIV3ztjd4>J0cI64K{6%!->Da9Pgcbzw__26@iQMQ9)-LF*_P(3KDnK5m
z8c|`YS6)x>{?#g&8AaT4Q@JUQ<3)InNYyL#hU{uOne=>-fKHn5sxuzziS@+dSSZ+E
zy@rRdd8U({O3~T~<+Givkunn)X=I(FD@4Hlz2~=~z5mwgd#-#Fp1oZ1H?VSBA@7kE
z+i5#ZFI0A6Ma&6yb(!vBdq306=Q~EH;5ESJ&1U`^(!d?#46o<SWe;jkg_XE)h6*^1
zcBHu+A>o`rjTQ>VvJ8c-4y&18kp>oRMXUrcR#PHzp}DcfoUe)j8PX`jy8}5q2r&HV
z;)8&*0iA@xM0_(qJIFsPCS*EtMZQ!g;vwO0G#=Xgn~LYW>0McCCHk4WJDhz=)bRp2
zx!m5LZ!SN-4M`ehPIL8n%_({<t~M?w%)qp4Hzg<e`@j2kl5Qz^(p65I#n{-sT%;eD
zemsL=PvCNi%B%EKrk{$@-amV(=-~!Q5ldogfyPg?2XM?hQsw~*80Tfa&9?FPbV58q
zuleg6L)1L>h7^=xrccuey!QS|t=@uG%GfE4O{gl~1QcJ}oGtT@k{=}v<Mf`0yyC9=
zLrfaplQGYd&yvhIZ41onjg~uXO$K>r14D!kS;)9?nsI8*d~>xR$D);B=t`<6Miog^
zP=^lB4BD^LAa_pH-L)2i(5XJUkLc$O9u+(@>EJLSuK&?n<V;2TU3$ZCeh2Ru%Z%Rg
ShMOYte4tW6?(`a_dHf$b$99(h

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x b/tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..0e5765f6ee4c07638c70647ae145e968718b67cd 100644
GIT binary patch
literal 360
zcmeb9bqvX1WME+Ock*}k2v%^42yj*a0-z8Bhz+7)Km*7?=EKC%X^=V)XaHgs5CaPU
znNtB32dQC$vIW$k3?Kzk!wkf%P$3YX2`UEC0}=;`ae=W2gAr7W703dq;{anOBsL>h
pJ=k8L!N~R^yOS7uPXNsZ*=NL%!XOExQ-JsckOiV);t2K$1^{D&4*>uG

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x b/tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..b45838adb7d304f8a36c38c90d89f3629ec48353 100644
GIT binary patch
literal 520
zcmWFzatz^MVqjn_cJg=j2v%^42yj*a0!9V~1`r!WgD@Njp!1m-QRP{gkok-naGg*F
z7hC|lI-mt$@PQeo5LF!uOc=(1(J1c3v=^ogl^*QsSQQwc;mZh&B?N$l37Y}~14zQr
eIl$Avz|hPAsstv_sKE*qfydhfm;gM0fdT+OoeTj0

literal 0
HcmV?d00001

-- 
2.43.0

