Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Vr+Q53H6"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D232126
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 00:52:41 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231207085237epoutp013f57dd097a6b4e8b8c131c8f282e84fe~egKWIP3Ai1389913899epoutp01y
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 08:52:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231207085237epoutp013f57dd097a6b4e8b8c131c8f282e84fe~egKWIP3Ai1389913899epoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701939157;
	bh=WGn63LbTKHCYX3ThaouVEOtKikWQfcJq14L17WhRsIQ=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=Vr+Q53H6bFFpwZTuhk1vI1sidU64hnfVlhH1uOk1sIIH26koDx0B4Qkt6ywTDezAA
	 U00y9KYJp7Y4/lIisjplavEHCos/19MlGoKrI+LRL+58DDLPgYc8Vh1n/37E3MnZeq
	 e4zLSuq6gbfhdbsQNI8vEcERC9dkmqkFbItAVnoY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20231207085237epcas2p12c1cb5f5c1ac8975d0114bac00957c72~egKV30te20153701537epcas2p1Z;
	Thu,  7 Dec 2023 08:52:37 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.101]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Sm7M85g4Qz4x9Pw; Thu,  7 Dec
	2023 08:52:36 +0000 (GMT)
X-AuditID: b6c32a48-963ff70000002587-d4-657187d40cdd
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	69.47.09607.4D781756; Thu,  7 Dec 2023 17:52:36 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: Re: [RFC PATCH v2 4/4] mm/mempolicy: implement a
 weighted-interleave
Reply-To: seungjun.ha@samsung.com
Sender: Seungjun Ha <seungjun.ha@samsung.com>
From: Seungjun Ha <seungjun.ha@samsung.com>
To: Gregory Price <gregory.price@memverge.com>
CC: Gregory Price <gourry.memverge@gmail.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, KyungSan Kim <ks0204.kim@samsung.com>, Wonjae
	Lee <wj28.lee@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZXCpNfTQN7ziFrZY@memverge.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231207085236epcms2p844b7c049fbf2906841d20e158d528896@epcms2p8>
Date: Thu, 07 Dec 2023 17:52:36 +0900
X-CMS-MailID: 20231207085236epcms2p844b7c049fbf2906841d20e158d528896
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmqe6V9sJUg8UvtC1e/HnOZNHQ9IjF
	4ugeDovzs06xWGy8/47NgdVj56y77B4bP/5n9+jbsorR4/MmuQCWqGybjNTElNQihdS85PyU
	zLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKC1SgpliTmlQKGAxOJiJX07m6L8
	0pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjGMHTjEWXJjBWPFtyxy2
	Bsb1Uxi7GDk5JARMJJrWLWHuYuTiEBLYwSgxb/sDli5GDg5eAUGJvzuEQWqEBYIl2p5eZAax
	hQQUJX582cEKEdeVmPv4ICNIOZuAtsSJ7fEgpoiAnsTH/54gE5kFtjBKdD9YyAyxildiRvtT
	FghbWmL78q1gJ3AK6Egsv78FqkZD4seyXihbVOLm6rfsMPb7Y/OhThaRaL13FqpGUOLBz91Q
	cSmJOZ+OQs0vlti8ZRcrhF0g0ffoAhuErS/ReP09mM0r4CvR3PQDzGYRUJW4sWIb1EwXiWu/
	u8DmMAO9tWzha2aQv5gFNCXW79IHMSUElCWO3IKq4JPoOPyXHebDHfOeMEHYqhIN+5uYYb79
	tnUd1GUeEic+PGKawKg4CxHMs5DsmoWwawEj8ypGsdSC4tz01GKjAhN43Cbn525iBCdALY8d
	jLPfftA7xMjEwXiIUYKDWUmEN+d8fqoQb0piZVVqUX58UWlOavEhRlOgLycyS4km5wNTcF5J
	vKGJpYGJmZmhuZGpgbmSOO+91rkpQgLpiSWp2ampBalFMH1MHJxSDUxWrMYmfbI758c95/y3
	x8/Qd8L6G8u3LdXY3Gaaw7Tr+sfZbE4CcXd+zb/5cZrdg62VIls3PXjzoO6o9ooPGRwr614/
	vPDU7mzQAwH7wl/O62OEtXTb1jy8UZ/ulPhy/jt29QPvXv15zJx64bdQQPit0/fKJXenvRDk
	uMytu+EkK+9U539yv9e9SLUNCnZZwvHwyuVGq8erV2x+tmrtw/8rP/xu/+n9oLowdUZC36fP
	8jvkV5j7HXn391zr1Gkd/y5I+3cprZk43WtzTTTX7NRF7tX3mpLFvD7v3FJyEpg2Lt6si2Lo
	7Nuxx1A40eCt9OK6uabi19kLItzlDI5JTa8+Ka/nFLYsblb93186J7UklViKMxINtZiLihMB
	4ohoyAkEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206080944epcms2p76ebb230b9f4595f5cfcd2531d67ab3ce
References: <ZXCpNfTQN7ziFrZY@memverge.com>
	<20231206080944epcms2p76ebb230b9f4595f5cfcd2531d67ab3ce@epcms2p7>
	<CGME20231206080944epcms2p76ebb230b9f4595f5cfcd2531d67ab3ce@epcms2p8>

> On Wed, Dec 06, 2023 at 05:09:44PM +0900, Seungjun Ha wrote:
> > > The weighted-interleave mempolicy implements weights per-node
> > > which are used to distribute memory while interleaving.
> > >
> > > For example:
> > >=C2=A0=20=C2=A0=20nodes:=200,1,2=0D=0A>=20>=20>=C2=A0=20=C2=A0=20weigh=
ts:=205,3,2=0D=0A>=20>=20>=0D=0A>=20>=20>=20Over=2010=20consecutive=20alloc=
ations,=20the=20following=20nodes=20will=20be=20selected:=0D=0A>=20>=20>=20=
=5B0,0,0,0,0,1,1,1,2,2=5D=0D=0A>=20>=20>=0D=0A>=20>=20>=20In=20this=20examp=
le=20there=20is=20a=2050%/30%/20%=20distribution=20of=20memory=20across=0D=
=0A>=20>=20>=20the=20enabled=20nodes.=0D=0A>=20>=20>=0D=0A>=20>=20>=20If=20=
a=20node=20is=20enabled,=20the=20minimum=20weight=20is=20expected=20to=20be=
=200.=20If=20an=0D=0A>=20>=20>=20enabled=20node=20ends=20up=20with=20a=20we=
ight=20of=200=20(as=20can=20happen=20if=20weights=0D=0A>=20>=20>=20are=20be=
ing=20recalculated=20due=20to=20a=20cgroup=20mask=20update),=20a=20minimum=
=0D=0A>=20>=20>=20of=201=20is=20applied=20during=20the=20interleave=20mecha=
nism.=0D=0A>=20>=0D=0A>=20>=20I=20found=20an=20issue=20while=20using=20the=
=20RFCv2,=20and=20want=20to=20report=20it.=C2=A0=0D=0A>=20=0D=0A>=20first,=
=20thank=20you=20very=20much=20for=20testing=21=20I'll=20run=20this=20on=20=
my=20latest=20fork.=0D=0A>=20=0D=0A>=20>=20In=20my=20testbed,=20calling=20s=
et_mempolicy2()=20causes=20pthread_create()=20failure=20or=20system=20hang,=
=20depending=20on=20weight=20combinations.=0D=0A>=20>=0D=0A>=0D=0A>=20I=20t=
hink=20this=20is=20likely=20because=20i=20did=20not=20handle=20__mpol_dup=
=20correctly.=0D=0A>=20The=20newer=20fork=20changes=20the=20way=20weights=
=20are=20stored,=20so=20this=20should=20not=0D=0A>=20but=20an=20issue,=20bu=
t=20I=20will=20use=20your=20test=20to=20validate=20this.=0D=0A>=0D=0A>=20Ne=
w=20RFC=20should=20hopefully=20be=20out=20this=20or=20next=20week.=0D=0A>=
=0D=0A=0D=0AFYI,=20send=20the=20whole=20dmesg=20log=20that=20occured=20in=
=20the=20problem=20situation.=0D=0A=0D=0A=5B=20=20464.155511=5D=20app:=20vm=
alloc=20error:=20size=20155648,=20failed=20to=20allocate=20pages,=20mode:0x=
dc2(GFP_KERNEL=7C__GFP_HIGHMEM=7C__GFP_ZERO),=20nodemask=3D(null),cpuset=3D=
/,mems_allowed=3D0-4=0D=0A=5B=20=20464.155550=5D=20CPU:=2093=20PID:=205281=
=20Comm:=20app=20Tainted:=20G=20=20=20=20=20=20D=20W=20=20=20E=20=20=20=20=
=20=206.6.0-rc4+=20=232=0D=0A=5B=20=20464.155561=5D=20Hardware=20name:=20In=
tel=20Corporation=20ArcherCity/ArcherCity,=20BIOS=20EGSDREL1.SYS.0085.D15.2=
207241333=2007/24/2022=0D=0A=5B=20=20464.155565=5D=20Call=20Trace:=0D=0A=5B=
=20=20464.155572=5D=20=20<TASK>=0D=0A=5B=20=20464.155580=5D=20=20dump_stack=
_lvl+0x48/0x70=0D=0A=5B=20=20464.155597=5D=20=20dump_stack+0x10/0x20=0D=0A=
=5B=20=20464.155602=5D=20=20warn_alloc+0x119/0x190=0D=0A=5B=20=20464.155613=
=5D=20=20?=20__vmalloc_node_range+0x1d2/0x850=0D=0A=5B=20=20464.155623=5D=
=20=20__vmalloc_node_range+0x7d4/0x850=0D=0A=5B=20=20464.155631=5D=20=20?=
=20kernel_clone+0x9d/0x3c0=0D=0A=5B=20=20464.155650=5D=20=20copy_process+0x=
a0f/0x1d20=0D=0A=5B=20=20464.155661=5D=20=20?=20kernel_clone+0x9d/0x3c0=0D=
=0A=5B=20=20464.155671=5D=20=20?=20__handle_mm_fault+0x769/0xdb0=0D=0A=5B=
=20=20464.155686=5D=20=20kernel_clone+0x9d/0x3c0=0D=0A=5B=20=20464.155698=
=5D=20=20__do_sys_clone+0x66/0x90=0D=0A=5B=20=20464.155712=5D=20=20__x64_sy=
s_clone+0x25/0x30=0D=0A=5B=20=20464.155722=5D=20=20do_syscall_64+0x59/0x90=
=0D=0A=5B=20=20464.155730=5D=20=20?=20exc_page_fault+0x8a/0x180=0D=0A=5B=20=
=20464.155739=5D=20=20entry_SYSCALL_64_after_hwframe+0x6e/0xd8=0D=0A=5B=20=
=20464.155750=5D=20RIP:=200033:0x7f50093f4125=0D=0A=5B=20=20464.155762=5D=
=20Code:=2048=2085=20ff=2074=203d=2048=2085=20f6=2074=2038=2048=2083=20ee=
=2010=2048=2089=204e=2008=2048=2089=203e=2048=2089=20d7=204c=2089=20c2=204d=
=2089=20c8=204c=208b=2054=2024=2008=20b8=2038=2000=2000=2000=200f=2005=20<4=
8>=2085=20c0=207c=2013=2074=2001=20c3=2031=20ed=2058=205f=20ff=20d0=2048=20=
89=20c7=20b8=203c=2000=2000=2000=0D=0A=5B=20=20464.155772=5D=20RSP:=20002b:=
00007ffea8877418=20EFLAGS:=2000000202=20ORIG_RAX:=200000000000000038=0D=0A=
=5B=20=20464.155781=5D=20RAX:=20ffffffffffffffda=20RBX:=2000007f50082cf700=
=20RCX:=2000007f50093f4125=0D=0A=5B=20=20464.155786=5D=20RDX:=2000007f50082=
cf9d0=20RSI:=2000007f50082cefb0=20RDI:=2000000000003d0f00=0D=0A=5B=20=20464=
.155791=5D=20RBP:=2000007ffea88774d0=20R08:=2000007f50082cf700=20R09:=20000=
07f50082cf700=0D=0A=5B=20=20464.155795=5D=20R10:=2000007f50082cf9d0=20R11:=
=200000000000000202=20R12:=2000007ffea88774ce=0D=0A=5B=20=20464.155799=5D=
=20R13:=2000007ffea88774cf=20R14:=2000007ffea88774d0=20R15:=2000007f50082ce=
fc0=0D=0A=5B=20=20464.155809=5D=20=20</TASK>=0D=0A=5B=20=20464.155852=5D=20=
Mem-Info:=0D=0A=5B=20=20464.155902=5D=20active_anon:1025=20inactive_anon:17=
4970=20isolated_anon:0=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20active_file:154846=20inactive_file:211215=20isolated_file:0=0D=0A=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20unevictable:2029=20dirty:237=20wr=
iteback:0=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20slab_reclaim=
able:32736=20slab_unreclaimable:106078=0D=0A=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20mapped:97039=20shmem:6403=20pagetables:3841=0D=0A=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20sec_pagetables:0=20bounce:0=0D=0A=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20kernel_misc_reclaimable:0=
=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20free:164219875=20free=
_pcp:36236=20free_cma:0=0D=0A=5B=20=20464.155921=5D=20Node=200=20active_ano=
n:2128kB=20inactive_anon:491864kB=20active_file:150184kB=20inactive_file:52=
2756kB=20unevictable:0kB=20isolated(anon):0kB=20isolated(file):0kB=20mapped=
:245188kB=20dirty:68kB=20writeback:0kB=20shmem:11812kB=20shmem_thp:0kB=20sh=
mem_pmdmapped:0kB=20anon_thp:0kB=20writeback_tmp:0kB=20kernel_stack:18552kB=
=20pagetables:9492kB=20sec_pagetables:0kB=20all_unreclaimable?=20no=0D=0A=
=5B=20=20464.155935=5D=20Node=201=20active_anon:1972kB=20inactive_anon:2080=
16kB=20active_file:469200kB=20inactive_file:322104kB=20unevictable:8116kB=
=20isolated(anon):0kB=20isolated(file):0kB=20mapped:142968kB=20dirty:880kB=
=20writeback:0kB=20shmem:13800kB=20shmem_thp:0kB=20shmem_pmdmapped:0kB=20an=
on_thp:0kB=20writeback_tmp:0kB=20kernel_stack:18712kB=20pagetables:5872kB=
=20sec_pagetables:0kB=20all_unreclaimable?=20no=0D=0A=5B=20=20464.155954=5D=
=20Node=200=20DMA=20free:11264kB=20boost:0kB=20min:8kB=20low:20kB=20high:32=
kB=20reserved_highatomic:0KB=20active_anon:0kB=20inactive_anon:0kB=20active=
_file:0kB=20inactive_file:0kB=20unevictable:0kB=20writepending:0kB=20presen=
t:15992kB=20managed:15360kB=20mlocked:0kB=20bounce:0kB=20free_pcp:0kB=20loc=
al_pcp:0kB=20free_cma:0kB=0D=0A=5B=20=20464.155970=5D=20lowmem_reserve=5B=
=5D:=200=201765=2064175=2064175=2064175=0D=0A=5B=20=20464.155988=5D=20Node=
=200=20DMA32=20free:1803124kB=20boost:0kB=20min:1236kB=20low:3040kB=20high:=
4844kB=20reserved_highatomic:0KB=20active_anon:0kB=20inactive_anon:0kB=20ac=
tive_file:0kB=20inactive_file:0kB=20unevictable:0kB=20writepending:0kB=20pr=
esent:1873332kB=20managed:1807640kB=20mlocked:0kB=20bounce:0kB=20free_pcp:4=
20kB=20local_pcp:0kB=20free_cma:0kB=0D=0A=5B=20=20464.156005=5D=20lowmem_re=
serve=5B=5D:=200=200=2062409=2062409=2062409=0D=0A=5B=20=20464.156023=5D=20=
Node=200=20Normal=20free:55826092kB=20boost:0kB=20min:43704kB=20low:107608k=
B=20high:171512kB=20reserved_highatomic:0KB=20active_anon:2128kB=20inactive=
_anon:491864kB=20active_file:150184kB=20inactive_file:522756kB=20unevictabl=
e:0kB=20writepending:68kB=20present:65011712kB=20managed:63907776kB=20mlock=
ed:0kB=20bounce:0kB=20free_pcp:59312kB=20local_pcp:592kB=20free_cma:0kB=0D=
=0A=5B=20=20464.156040=5D=20lowmem_reserve=5B=5D:=200=200=200=200=200=0D=0A=
=5B=20=20464.156053=5D=20Node=201=20Normal=20free:62368616kB=20boost:0kB=20=
min:45156kB=20low:111184kB=20high:177212kB=20reserved_highatomic:0KB=20acti=
ve_anon:1972kB=20inactive_anon:208016kB=20active_file:469200kB=20inactive_f=
ile:322104kB=20unevictable:8116kB=20writepending:880kB=20present:67108864kB=
=20managed:66029252kB=20mlocked:0kB=20bounce:0kB=20free_pcp:85212kB=20local=
_pcp:652kB=20free_cma:0kB=0D=0A=5B=20=20464.156067=5D=20lowmem_reserve=5B=
=5D:=200=200=200=200=200=0D=0A=5B=20=20464.156078=5D=20Node=200=20DMA:=200*=
4kB=200*8kB=200*16kB=200*32kB=200*64kB=200*128kB=200*256kB=200*512kB=201*10=
24kB=20(U)=201*2048kB=20(M)=202*4096kB=20(M)=20=3D=2011264kB=0D=0A=5B=20=20=
464.156106=5D=20Node=200=20DMA32:=207*4kB=20(UM)=209*8kB=20(M)=207*16kB=20(=
M)=207*32kB=20(M)=207*64kB=20(M)=208*128kB=20(M)=204*256kB=20(M)=204*512kB=
=20(M)=206*1024kB=20(M)=205*2048kB=20(M)=20435*4096kB=20(M)=20=3D=201803124=
kB=0D=0A=5B=20=20464.156142=5D=20Node=200=20Normal:=200*4kB=20443*8kB=20(UM=
E)=201063*16kB=20(UME)=202103*32kB=20(UME)=201484*64kB=20(UME)=20859*128kB=
=20(UME)=20416*256kB=20(UME)=20204*512kB=20(UM)=2064*1024kB=20(UME)=2011*20=
48kB=20(M)=2013485*4096kB=20(M)=20=3D=2055826344kB=0D=0A=5B=20=20464.156178=
=5D=20Node=201=20Normal:=20585*4kB=20(UME)=20489*8kB=20(UME)=20306*16kB=20(=
UME)=20493*32kB=20(UME)=20199*64kB=20(UME)=20137*128kB=20(UME)=2011*256kB=
=20(UME)=2036*512kB=20(UM)=2040*1024kB=20(UM)=207*2048kB=20(UME)=2015194*40=
96kB=20(M)=20=3D=2062368364kB=0D=0A=5B=20=20464.156225=5D=20Node=200=20huge=
pages_total=3D0=20hugepages_free=3D0=20hugepages_surp=3D0=20hugepages_size=
=3D1048576kB=0D=0A=5B=20=20464.156232=5D=20Node=200=20hugepages_total=3D0=
=20hugepages_free=3D0=20hugepages_surp=3D0=20hugepages_size=3D2048kB=0D=0A=
=5B=20=20464.156238=5D=20Node=201=20hugepages_total=3D0=20hugepages_free=3D=
0=20hugepages_surp=3D0=20hugepages_size=3D1048576kB=0D=0A=5B=20=20464.15624=
3=5D=20Node=201=20hugepages_total=3D0=20hugepages_free=3D0=20hugepages_surp=
=3D0=20hugepages_size=3D2048kB=0D=0A=5B=20=20464.156248=5D=20Node=202=20hug=
epages_total=3D0=20hugepages_free=3D0=20hugepages_surp=3D0=20hugepages_size=
=3D1048576kB=0D=0A=5B=20=20464.156255=5D=20Node=202=20hugepages_total=3D0=
=20hugepages_free=3D0=20hugepages_surp=3D0=20hugepages_size=3D2048kB=0D=0A=
=5B=20=20464.156259=5D=20Node=203=20hugepages_total=3D0=20hugepages_free=3D=
0=20hugepages_surp=3D0=20hugepages_size=3D1048576kB=0D=0A=5B=20=20464.15626=
3=5D=20Node=203=20hugepages_total=3D0=20hugepages_free=3D0=20hugepages_surp=
=3D0=20hugepages_size=3D2048kB=0D=0A=5B=20=20464.156266=5D=20Node=204=20hug=
epages_total=3D0=20hugepages_free=3D0=20hugepages_surp=3D0=20hugepages_size=
=3D1048576kB=0D=0A=5B=20=20464.156270=5D=20Node=204=20hugepages_total=3D0=
=20hugepages_free=3D0=20hugepages_surp=3D0=20hugepages_size=3D2048kB=0D=0A=
=5B=20=20464.156275=5D=20369910=20total=20pagecache=20pages=0D=0A=5B=20=204=
64.156280=5D=200=20pages=20in=20swap=20cache=0D=0A=5B=20=20464.156283=5D=20=
Free=20swap=20=20=3D=2010485756kB=0D=0A=5B=20=20464.156286=5D=20Total=20swa=
p=20=3D=2010485756kB=0D=0A=5B=20=20464.156290=5D=20167720203=20pages=20RAM=
=0D=0A=5B=20=20464.156293=5D=200=20pages=20HighMem/MovableOnly=0D=0A=5B=20=
=20464.156296=5D=20562468=20pages=20reserved=0D=0A=5B=20=20464.156299=5D=20=
0=20pages=20hwpoisoned=0D=0A=5B=20=20464.156331=5D=20general=20protection=
=20fault,=20probably=20for=20non-canonical=20address=200x300b162afbcb6e0f:=
=200000=20=5B=232=5D=20PREEMPT=20SMP=20NOPTI=0D=0A=5B=20=20464.156341=5D=20=
CPU:=2093=20PID:=205281=20Comm:=20app=20Tainted:=20G=20=20=20=20=20=20D=20W=
=20=20=20E=20=20=20=20=20=206.6.0-rc4+=20=232=0D=0A=5B=20=20464.156350=5D=
=20Hardware=20name:=20Intel=20Corporation=20ArcherCity/ArcherCity,=20BIOS=
=20EGSDREL1.SYS.0085.D15.2207241333=2007/24/2022=0D=0A=5B=20=20464.156355=
=5D=20RIP:=200010:vfree+0x7e/0x2d0=0D=0A=5B=20=20464.156364=5D=20Code:=2048=
=2085=20c0=200f=2084=2042=2002=2000=2000=208b=2050=202c=20f6=2040=2019=2001=
=200f=2085=200c=2001=2000=2000=2085=20d2=200f=2085=2085=2000=2000=2000=20e9=
=2096=2000=2000=2000=2066=2090=20e8=2042=206c=20e0=20ff=20<49>=208b=2044=20=
24=2008=20a8=2001=200f=2085=20e2=2000=2000=2000=200f=201f=2044=2000=2000=20=
4c=2089=20e0=2048=0D=0A=5B=20=20464.156373=5D=20RSP:=200018:ffa000000cfebc0=
0=20EFLAGS:=2000010202=0D=0A=5B=20=20464.156379=5D=20RAX:=20000000000000000=
1=20RBX:=200000000000000006=20RCX:=200000000000000000=0D=0A=5B=20=20464.156=
384=5D=20RDX:=20ff11001086c2e000=20RSI:=20000000000000009a=20RDI:=200000000=
0ffffffff=0D=0A=5B=20=20464.156389=5D=20RBP:=20ffa000000cfebc30=20R08:=2000=
00000000000000=20R09:=20ff1100203f1784c0=0D=0A=5B=20=20464.156394=5D=20R10:=
=20ffd40000046248c8=20R11:=200000000000000000=20R12:=20300b162afbcb6e07=0D=
=0A=5B=20=20464.156397=5D=20R13:=20ff1100108ecd9340=20R14:=2000000000ffffff=
ff=20R15:=20ff1100108ecd9340=0D=0A=5B=20=20464.156401=5D=20FS:=20=2000007f5=
0092d2740(0000)=20GS:ff1100203f140000(0000)=20knlGS:0000000000000000=0D=0A=
=5B=20=20464.156408=5D=20CS:=20=200010=20DS:=200000=20ES:=200000=20CR0:=200=
000000080050033=0D=0A=5B=20=20464.156415=5D=20CR2:=2000007f50082cefb8=20CR3=
:=2000000011535fa006=20CR4:=200000000000771ee0=0D=0A=5B=20=20464.156422=5D=
=20DR0:=200000000000000000=20DR1:=200000000000000000=20DR2:=200000000000000=
000=0D=0A=5B=20=20464.156426=5D=20DR3:=200000000000000000=20DR6:=2000000000=
fffe07f0=20DR7:=200000000000000400=0D=0A=5B=20=20464.156430=5D=20PKRU:=2055=
555554=0D=0A=5B=20=20464.156434=5D=20Call=20Trace:=0D=0A=5B=20=20464.156438=
=5D=20=20<TASK>=0D=0A=5B=20=20464.156442=5D=20=20?=20show_regs+0x68/0x70=0D=
=0A=5B=20=20464.156457=5D=20=20?=20__die_body+0x20/0x70=0D=0A=5B=20=20464.1=
56467=5D=20=20?=20die_addr+0x3e/0x60=0D=0A=5B=20=20464.156477=5D=20=20?=20e=
xc_general_protection+0x231/0x460=0D=0A=5B=20=20464.156491=5D=20=20?=20asm_=
exc_general_protection+0x27/0x30=0D=0A=5B=20=20464.156503=5D=20=20?=20vfree=
+0x7e/0x2d0=0D=0A=5B=20=20464.156512=5D=20=20__vmalloc_node_range+0x7dd/0x8=
50=0D=0A=5B=20=20464.156523=5D=20=20?=20kernel_clone+0x9d/0x3c0=0D=0A=5B=20=
=20464.156538=5D=20=20copy_process+0xa0f/0x1d20=0D=0A=5B=20=20464.156549=5D=
=20=20?=20kernel_clone+0x9d/0x3c0=0D=0A=5B=20=20464.156559=5D=20=20?=20__ha=
ndle_mm_fault+0x769/0xdb0=0D=0A=5B=20=20464.156569=5D=20=20kernel_clone+0x9=
d/0x3c0=0D=0A=5B=20=20464.156582=5D=20=20__do_sys_clone+0x66/0x90=0D=0A=5B=
=20=20464.156594=5D=20=20__x64_sys_clone+0x25/0x30=0D=0A=5B=20=20464.156606=
=5D=20=20do_syscall_64+0x59/0x90=0D=0A=5B=20=20464.156613=5D=20=20?=20exc_p=
age_fault+0x8a/0x180=0D=0A=5B=20=20464.156620=5D=20=20entry_SYSCALL_64_afte=
r_hwframe+0x6e/0xd8=0D=0A=5B=20=20464.156627=5D=20RIP:=200033:0x7f50093f412=
5=0D=0A=5B=20=20464.156631=5D=20Code:=2048=2085=20ff=2074=203d=2048=2085=20=
f6=2074=2038=2048=2083=20ee=2010=2048=2089=204e=2008=2048=2089=203e=2048=20=
89=20d7=204c=2089=20c2=204d=2089=20c8=204c=208b=2054=2024=2008=20b8=2038=20=
00=2000=2000=200f=2005=20<48>=2085=20c0=207c=2013=2074=2001=20c3=2031=20ed=
=2058=205f=20ff=20d0=2048=2089=20c7=20b8=203c=2000=2000=2000=0D=0A=5B=20=20=
464.156636=5D=20RSP:=20002b:00007ffea8877418=20EFLAGS:=2000000202=20ORIG_RA=
X:=200000000000000038=0D=0A=5B=20=20464.156643=5D=20RAX:=20ffffffffffffffda=
=20RBX:=2000007f50082cf700=20RCX:=2000007f50093f4125=0D=0A=5B=20=20464.1566=
48=5D=20RDX:=2000007f50082cf9d0=20RSI:=2000007f50082cefb0=20RDI:=2000000000=
003d0f00=0D=0A=5B=20=20464.156652=5D=20RBP:=2000007ffea88774d0=20R08:=20000=
07f50082cf700=20R09:=2000007f50082cf700=0D=0A=5B=20=20464.156657=5D=20R10:=
=2000007f50082cf9d0=20R11:=200000000000000202=20R12:=2000007ffea88774ce=0D=
=0A=5B=20=20464.156661=5D=20R13:=2000007ffea88774cf=20R14:=2000007ffea88774=
d0=20R15:=2000007f50082cefc0=0D=0A=5B=20=20464.156668=5D=20=20</TASK>=0D=0A=
=5B=20=20464.156670=5D=20Modules=20linked=20in:=20xt_conntrack(E)=20xt_MASQ=
UERADE(E)=20nf_conntrack_netlink(E)=20nfnetlink(E)=20xfrm_user(E)=20xfrm_al=
go(E)=20iptable_nat(E)=20nf_nat(E)=20nf_conntrack(E)=20nf_defrag_ipv6(E)=20=
nf_defrag_ipv4(E)=20libcrc32c(E)=20xt_addrtype(E)=20iptable_filter(E)=20bpf=
ilter(E)=20br_netfilter(E)=20bridge(E)=20stp(E)=20llc(E)=20overlay(E)=20nls=
_iso8859_1(E)=20intel_rapl_msr(E)=20intel_rapl_common(E)=20intel_uncore_fre=
quency(E)=20intel_uncore_frequency_common(E)=20i10nm_edac(E)=20nfit(E)=20sn=
d_hda_codec_realtek(E)=20snd_hda_codec_generic(E)=20ledtrig_audio(E)=20x86_=
pkg_temp_thermal(E)=20intel_powerclamp(E)=20coretemp(E)=20snd_hda_intel(E)=
=20kvm_intel(E)=20kmem(E)=20snd_intel_dspcfg(E)=20snd_intel_sdw_acpi(E)=20i=
nput_leds(E)=20device_dax(E)=20snd_hda_codec(E)=20kvm(E)=20cxl_mem(E)=20snd=
_hda_core(E)=20cxl_port(E)=20crct10dif_pclmul(E)=20cxl_pmu(E)=20snd_hwdep(E=
)=20ghash_clmulni_intel(E)=20snd_pcm(E)=20sha512_ssse3(E)=20binfmt_misc(E)=
=20snd_seq_midi(E)=20snd_seq_midi_event(E)=20aesni_intel(E)=20crypto_simd(E=
)=20snd_rawmidi(E)=20cryptd(E)=20snd_seq(E)=20rapl(E)=20ast(E)=20drm_shmem_=
helper(E)=20dax_hmem(E)=20snd_seq_device(E)=0D=0A=5B=20=20464.156784=5D=20=
=20intel_cstate(E)=20snd_timer(E)=20drm_kms_helper(E)=20cxl_acpi(E)=20cxl_p=
ci(E)=20isst_if_mmio(E)=20i2c_algo_bit(E)=20isst_if_mbox_pci(E)=20snd(E)=20=
mei_me(E)=20idxd(E)=20isst_if_common(E)=20ipmi_ssif(E)=20cxl_core(E)=20idxd=
_bus(E)=20soundcore(E)=20mei(E)=20acpi_ipmi(E)=20ipmi_si(E)=20ipmi_devintf(=
E)=20ipmi_msghandler(E)=20acpi_power_meter(E)=20acpi_pad(E)=20mac_hid(E)=20=
sch_fq_codel(E)=20msr(E)=20parport_pc(E)=20ppdev(E)=20lp(E)=20ramoops(E)=20=
parport(E)=20reed_solomon(E)=20drm(E)=20efi_pstore(E)=20ip_tables(E)=20x_ta=
bles(E)=20autofs4(E)=20hid_generic(E)=20usbhid(E)=20hid(E)=20i2c_i801(E)=20=
nvme(E)=20ahci(E)=20xhci_pci(E)=20nvme_core(E)=20libahci(E)=20i2c_smbus(E)=
=20crc32_pclmul(E)=20igc(E)=20i2c_ismt(E)=20xhci_pci_renesas(E)=20wmi(E)=20=
pinctrl_emmitsburg(E)=0D=0A=5B=20=20464.156883=5D=20---=5B=20end=20trace=20=
0000000000000000=20=5D---=0D=0A=5B=20=20464.344754=5D=20RIP:=200010:vfree+0=
x7e/0x2d0=0D=0A=5B=20=20464.344764=5D=20Code:=2048=2085=20c0=200f=2084=2042=
=2002=2000=2000=208b=2050=202c=20f6=2040=2019=2001=200f=2085=200c=2001=2000=
=2000=2085=20d2=200f=2085=2085=2000=2000=2000=20e9=2096=2000=2000=2000=2066=
=2090=20e8=2042=206c=20e0=20ff=20<49>=208b=2044=2024=2008=20a8=2001=200f=20=
85=20e2=2000=2000=2000=200f=201f=2044=2000=2000=204c=2089=20e0=2048=0D=0A=
=5B=20=20464.344772=5D=20RSP:=200018:ffa000000ce73bf0=20EFLAGS:=2000010202=
=0D=0A=5B=20=20464.344788=5D=20RAX:=200000000000000001=20RBX:=2000000000000=
00006=20RCX:=200000000000000000=0D=0A=5B=20=20464.344799=5D=20RDX:=20ff1100=
01260a2000=20RSI:=2000000000000000c5=20RDI:=2000000000ffffffff=0D=0A=5B=20=
=20464.344806=5D=20RBP:=20ffa000000ce73c20=20R08:=200000000000000000=20R09:=
=20ff1100103f4784c0=0D=0A=5B=20=20464.344813=5D=20R10:=20ffd40000042e6c88=
=20R11:=200000000000000000=20R12:=20d0ec0eba6bd389a7=0D=0A=5B=20=20464.3448=
20=5D=20R13:=20ff1100010fd51880=20R14:=2000000000ffffffff=20R15:=20ff110001=
0fd51880=0D=0A=5B=20=20464.344826=5D=20FS:=20=2000007f50092d2740(0000)=20GS=
:ff1100203f140000(0000)=20knlGS:0000000000000000=0D=0A=5B=20=20464.344836=
=5D=20CS:=20=200010=20DS:=200000=20ES:=200000=20CR0:=200000000080050033=0D=
=0A=5B=20=20464.344843=5D=20CR2:=2000007f50082cefb8=20CR3:=2000000011535fa0=
06=20CR4:=200000000000771ee0=0D=0A=5B=20=20464.344850=5D=20DR0:=20000000000=
0000000=20DR1:=200000000000000000=20DR2:=200000000000000000=0D=0A=5B=20=204=
64.344856=5D=20DR3:=200000000000000000=20DR6:=2000000000fffe07f0=20DR7:=200=
000000000000400=0D=0A=5B=20=20464.344863=5D=20PKRU:=2055555554=0D=0A
