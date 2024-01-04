Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99492555F
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UCBmpQE5"
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20240104164458usoutp012110250a0d34d83f2b6be0dbbb4ae720~nMqwBOjXJ0720107201usoutp01k;
	Thu,  4 Jan 2024 16:44:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20240104164458usoutp012110250a0d34d83f2b6be0dbbb4ae720~nMqwBOjXJ0720107201usoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704386698;
	bh=J8QReWc6INjr8Uyi+JkS99MLKy4cMZCq5McZYztO8UE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=UCBmpQE5SXl/BrfxXgH8D/aon3uKAcykjuYTToY5O8+HytJNKEv2Ul4blk/cMvSWS
	 zxRVuwSZv44ZZLR2nuJYhEqTt7548+UilcSDRowmiOqd1LKig5ro9K6X8LI00uoPX+
	 fs5Fygiq9FHFYBQzpO4a0NkpB9qnlRKC4Fr2K8sk=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
	[203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240104164458uscas1p264b2806ab0cddaddf0699b199bbc67e5~nMqv7XWo51227612276uscas1p2w;
	Thu,  4 Jan 2024 16:44:58 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges2new.samsung.com (USCPEMTA) with SMTP id 4B.6D.09760.980E6956; Thu, 
	4 Jan 2024 11:44:58 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
	[203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240104164457uscas1p21d81b95d64dae6021d1e34ff55a3e9ef~nMqvlB5Mc1229512295uscas1p21;
	Thu,  4 Jan 2024 16:44:57 +0000 (GMT)
X-AuditID: cbfec36f-7f9ff70000002620-e9-6596e0891095
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id DC.B8.09813.980E6956; Thu, 
	4 Jan 2024 11:44:57 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Thu, 4 Jan 2024 08:44:57 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Thu,
	4 Jan 2024 08:44:57 -0800
From: Jim Harris <jim.harris@samsung.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFC] Add "uunit" unit testing framework for CXL code
Thread-Topic: [PATCH RFC] Add "uunit" unit testing framework for CXL code
Thread-Index: AQHaJujGLtImsgu5/E6TZ8871cwEbbDJ6SyAgACpwYA=
Date: Thu, 4 Jan 2024 16:44:57 +0000
Message-ID: <ZZbgewv5l5LMmrTk@ubuntu>
In-Reply-To: <65965214f008e_8dc68294d0@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB9607B25EE52F4996BB552972670A52@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduzrOd2uB9NSDZr2sVpMn3qB0eL8rFMs
	Dkwei/e8ZPL4vEkugCmKyyYlNSezLLVI3y6BK+Pr/jfMBZujKq5Ou8fawHjdo4uRg0NCwETi
	yX+JLkYuDiGBlYwSvWeOMkI4rUwSp68dZ+li5AQr2jfrFRtEYg2jxPWLu9ghnI+MEg+W3GWF
	cJYySqx4v5cZpIVNQFPi15U1TCC2iIC2xMQ5B8HizALWEv2nz4LZwgIeEpeO74Sq8ZSYt2k2
	G4RtJXFt52d2EJtFQEXiy5PLjCA2r4CqxI3728HinED1Mw+vALMZBcQkvp+C2MUsIC5x68l8
	JoizBSUWzd7DDGGLSfzb9ZANwlaUuP/9JTtEvY7Egt2f2CBsO4mGZWuh7tSWWLbwNTPEXkGJ
	kzOfQINCUuLgihssIA9LCEzlkLh78ijUMheJI//Xs0LY0hJ/7y6DimdLrFzfwQQJ7AKJhiNB
	EGFriYV/1jNNYFSZheTsWUhOmoXkpFlITpqF5KQFjKyrGMVLi4tz01OLjfJSy/WKE3OLS/PS
	9ZLzczcxAtPJ6X+H83cwXr/1Ue8QIxMH4yFGCQ5mJRHe9esmpwrxpiRWVqUW5ccXleakFh9i
	lOZgURLnNbQ9mSwkkJ5YkpqdmlqQWgSTZeLglGpg0gli/G5inGTBWcK9d77ErZvrNzAtVpyi
	2jn59kHHtfdecj0rMdhQ77f/cuvvH49Wqec90Nj6beuDjfwTBcS4a8u45GqyQ9f5mkx7kP14
	4QOpP+0yJlnO0a52TIYfguZ9VLeY/SFMy0x4n4D7siPTrm8Uz/ke8nPVqmTbO9l3ZjPk112f
	cD63M+Sin1SJs9btg7yvozYs1MkOS5smvHWLZTf/dr3GHxM0jWyOn/TUztbpy6r8Gvc1zKdb
	xOHx6hfJpn+FO7jrecXcN7ydKlW3xe12xp6dot1HPV3Wp76Vbfs4J9OUNSgwyfmc/J8zrzt5
	dbfXMnve2D4vSONzVN2naKaSEul98db+BuLucX5KLMUZiYZazEXFiQCm1q9UlgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWS2cDsrNv5YFqqwdV5BhbTp15gtDg/6xSL
	A5PH4j0vmTw+b5ILYIrisklJzcksSy3St0vgyvi6/w1zweaoiqvT7rE2MF736GLk5JAQMJHY
	N+sVWxcjF4eQwCpGiUnPfrJDOB8ZJQ7e7mKGcJYySvT9+ccO0sImoCnx68oaJhBbREBbYuKc
	g8wgNrOAtUT/6bNgtrCAh8Sl4zuhajwl5m2azQZhW0lc2/kZbA6LgIrElyeXGUFsXgFViRv3
	t0NtvsoosWvlKrAiTqDmmYdXgNmMAmIS309BLGYWEJe49WQ+E8QPAhJL9pxnhrBFJV4+/scK
	YStK3P/+kh2iXkdiwe5PbBC2nUTDsrVQR2tLLFv4mhniCEGJkzOfsED0SkocXHGDZQKjxCwk
	62YhGTULyahZSEbNQjJqASPrKkbx0uLi3PSKYqO81HK94sTc4tK8dL3k/NxNjMB4PP3vcPQO
	xtu3PuodYmTiYDzEKMHBrCTCu37d5FQh3pTEyqrUovz4otKc1OJDjNIcLErivHcfaKQKCaQn
	lqRmp6YWpBbBZJk4OKUamHZNYA4QzH9mbbjBTn1qd5NgIvf+n4rdmdszpd0FJQWq7ENf3j02
	541Mimm7/X4Ouwk/Nspbpa5X//BPrq5QWG/6wY97tG6I5fT1ss6fekhOuCqeVXZreZrZff5e
	t8J8A84VrZsalzIoTrfbeKvq+HPJSROPHDlcu2rBbiuz72vkXyopBC64HtamOCH7rgRP9ifL
	L0WqqRyvWBiabub7ewn7dS7xvhx5w+WZzPmUKz5XTk73ZHfVOxkcozBnze5P20QjHrfNL3Q5
	9L122XNODWuGpvLO2VU9VU+6tXyOThNt465wrtSWiJ8j3r9PwrcjaHKOU1sWo73PgqhuzlgD
	04qHrsxKd87KnEzYdE2JpTgj0VCLuag4EQBynwYDNgMAAA==
X-CMS-MailID: 20240104164457uscas1p21d81b95d64dae6021d1e34ff55a3e9ef
CMS-TYPE: 301P
X-CMS-RootMailID: 20231204193337uscas1p24b1959cf528b02b8172736a61807fff1
References: <CGME20231204193337uscas1p24b1959cf528b02b8172736a61807fff1@uscas1p2.samsung.com>
	<170171841563.162223.2230646078958595847.stgit@ubuntu>
	<65965214f008e_8dc68294d0@dwillia2-xfh.jf.intel.com.notmuch>

On Wed, Jan 03, 2024 at 10:37:09PM -0800, Dan Williams wrote:

Dan,

Thanks for the detailed review!

> Jim Harris wrote:
> >=20
> > There is a balance currently between creating stubs for referenced func=
tions,
> > versus just building and linking the referenced source files directly. =
For
> > example, CXL uses xarray extensively, so we just build and link the xar=
ray
> > code directly into unit tests rather than creating stubs for xarray. Se=
e
> > KERNEL_SRC in the Makefile for which kernel source files are directly b=
uilt
> > and linked in this manner.
>=20
> Explain that balance a bit more, is it mainly just a "hey I want that
> function, oh building that new file is going to take me hours to work
> around a bunch of new dependencies, I'll just stub the one function I
> need."?

Yes, that's the general idea. You'll notice in the Makefile that 11 out of =
the
13 source files that are used directly are in lib/, since these are at the
relative bottom of the dependency chart. drivers/base/ was a bit trickier,
this original RFC builds two of those files directly, but you'll see a lot
of stubs for other drivers/base/ files. IIRC, I tried to use
drivers/base/core.c directly to avoid the 15-20 stubs, but that would have
resulted in needing 30+ stubs for all of its dependencies.

>=20
> > Stubs are in uunit/stub.c, and are grouped by the kernel source file co=
ntaining
> > the real definition. Those groups are listed in alphabetical order.
> >=20
> > The build process has five primary steps:
> >=20
> > Capture kernel build flags - use 'make -qp' to pull LINUXINCLUDE,
> > KBUILD_CPPFLAGS, KBUILD_CFLAGS from the top-level kernel Makefile.
>=20
> Did you look into stealing from tools/build/? I don't think it includes
> those variables, but I suspect it includes some Makefile helpers that
> are open coded. Reusing tools/build/ likely helps with selling others on
> this uunit approach.

No, I'll check that out. Thanks for the tip.

> >=20
> > Create unit test build environment - remove thunking, fentry and
> > stack-protector options from the kernel build flags. Also provide
> > KBUILD_XXX strings.
> >=20
> > Modified headers - some kernel headers require modification - don't
> > modify them inline though, create a copy in the uunit/build directory,
> > modify them, and set the include directories so that the build will
> > pick up the modified copy first. Explanations for the modified headers
> > are in the Makefile.
> >=20
> > Wrap and build kernel source - kernel defines many functions that are
> > also in libc. Kernel also defines some data structures with same name
> > as /usr/include data structures. So we wrap all kernel source files
> > with uunit/include/pre.h and uunit/include/post.h to do some
> > pre-processor magic to eliminate these conflicts.
>=20
> How much of an ongoing maintenance burden do you expect this to be? I
> guess it all depends on how fast moving those headers are, but I worry
> about bitrot unless we can get this into some automated environment that
> notices that new changes heading into linux-next are breaking the uunit
> build.

I expect very little if any maintenance burden for the pre.h and post.h
helpers. These handle conflicts for well-established function and type name=
s.
It's certainly possible this list will grow somewhat if this framework scal=
es
outside of just CXL, but generally should be very stable.

The modified headers do carry some maintenance burden however, especially
autoconf.h. I've only tested with a limited number of kernel configurations
and architectures (x86_64, arm64) so the list of config options we need to
disable could grow as this gets exposure to more kernel configs.
=20
> > Build unit test applications - found in uunit/app directory, and named
>=20
> NIT is "app" idiomatic for CUnit? I would otherwise just call it the
> "test" directory for where the test executables end up.

Ack.
=20
> > like core_region_ut.c to associate with core/region.c. The test
> > applications include the stub.c file directly - this will enable future
> > use cases where stubs can be configured to return specific mocked value=
s.
> >=20
> > Note that this framework is not CXL-specific - it could be used to unit
> > test a vast majority of other kernel code. Proposal is to just start
> > with this framework in tools/testing/cxl to meet CXL-specific needs.
>=20
> Certainly all the pre-work you have done to process kernel headers is
> generally useful work for others that want to adopt this test approach.
>=20
> The scaling challenge comes when there is disagreement about
> stub-behavior across tests, right? Or would a test just override the
> default stub?

Ah, you're already getting into stage 2. As we find stubs that require
modified behavior per-test, we will have variables that tests can set to
modify that behavior.

I have an RFC v2 I'm getting ready to send out, I'll add an example of this
just to show the concept. Now that I have your extensive feedback, I'll
probably drop the RFC tag as well.
=20
> > Todos:
> >=20
> > 1) Integrate with tools/testing/cxl Makefile
>=20
> I am ok if this stands alone. As I mentioned above reusing tools/build/
> is likely more important. tools/testing/cxl/ is building a kernel
> module, tools/build/ is there to support userpace executables built out
> of the tools/ directory.

Ack.

> > 2) Break out CXL stubs separately by source file. This will be required=
 as
> >    we start testing more and more CXL files and need to exclude stubs t=
hat
> >    are defined in the source file under test.
>=20
> You mean like in cases where one test wants one stub behavior and
> another has wants a different one.

No, it's for the case where we have both unit tests and stubs for multiple
source files. For example, if stub.c has port.c stubs in it, we will get
multiple definition failures when compiling port.c unit tests.

In my v2, I just wrap stubs with "#ifndef UUNIT_CORE_PORT_C", and then
the port.c unit tests define this before including stub.c to avoid the
multiple definitions. This seems good enough for now, but may require some
changes if this scales outside of just CXL. Maybe we just use a fully
qualified name like UUNIT_DRIVERS_CXL_CORE_PORT_C.

>=20
> > 3) Build common library for building up parts of the CXL topology. For =
example,
> >    see everything needed to set up ports, decoders, etc. to test the
> >    region.c code. Much of this can be simplified in a way that various
> >    topologies can be built without as much boilerplate code, not only f=
or
> >    region.c but other files as well.
>=20
> Do you mean de-duplicating some of the logic in
> cxl_port_setup_targets_test() and cxl_region_setup_targets_test()?

Exactly. I'll have a lot of this in the v2.

> > 4) Improve cxl_region tests to cover error conditions and add extensive
> >    comments explaining how the topology is being built. This overlaps w=
ith #3.
>=20
> Some comments on the simple tests would help too just to get folks
> ramped about what's going on.

Ack. The comments are absolutely critical and I should have added them in t=
he
v1. They'll be in the v2.

>=20
> >=20
> > Signed-off-by: Jim Harris <jim.harris@samsung.com>
> > ---
> >  tools/testing/cxl/uunit/Makefile             |  141 +++++++++++
> >  tools/testing/cxl/uunit/app/core_hdm_ut.c    |   82 ++++++
> >  tools/testing/cxl/uunit/app/core_region_ut.c |  237 ++++++++++++++++++
> >  tools/testing/cxl/uunit/include/post.h       |   21 ++
> >  tools/testing/cxl/uunit/include/pre.h        |   22 ++
> >  tools/testing/cxl/uunit/stub.c               |  335 ++++++++++++++++++=
++++++++
> >  6 files changed, 838 insertions(+)
> >  create mode 100644 tools/testing/cxl/uunit/Makefile
> >  create mode 100644 tools/testing/cxl/uunit/app/core_hdm_ut.c
> >  create mode 100644 tools/testing/cxl/uunit/app/core_region_ut.c
> >  create mode 100644 tools/testing/cxl/uunit/include/post.h
> >  create mode 100644 tools/testing/cxl/uunit/include/pre.h
> >  create mode 100644 tools/testing/cxl/uunit/stub.c
>=20
> This overall looks promising, the tools/build/ question might be the
> only consideration for merging in the near term.
>=20
> Some inline comments below:
>=20
> [..]
> > +
> > +	CU_ASSERT(add_hdm_decoder(&port, &decoder, targets) =3D=3D 0);
>=20
> Likely wants some commentary on why it is ok to pass uninitialized stack
> variables into add_hdm_decoder().

Ack.

> > +}
> > +
> > +static void
> > +cxl_settle_decoders_test(void)
> > +{
> > +	struct cxl_hdm hdm;
> > +	char _regs[0x200];
> > +	void *regs =3D _regs;
> > +	unsigned int msecs;
> > +
> > +	*(long *)&_regs[CXL_HDM_DECODER0_CTRL_OFFSET(0)] =3D CXL_HDM_DECODER0=
_CTRL_COMMITTED;
> > +	*(long *)&_regs[CXL_HDM_DECODER0_CTRL_OFFSET(1)] =3D CXL_HDM_DECODER0=
_CTRL_COMMITTED;
> > +	*(long *)&_regs[CXL_HDM_DECODER0_CTRL_OFFSET(2)] =3D 0;
>=20
> Can this be made to look more like idiomatic kernel code? E.g.:
>=20
>     writel(val, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(x))
>=20
> ...so that code sequences can be copied from the driver into the tests?

Ack.

> > diff --git a/tools/testing/cxl/uunit/app/core_region_ut.c b/tools/testi=
ng/cxl/uunit/app/core_region_ut.c
> > new file mode 100644
> > index 000000000000..770ec200c87f
> > --- /dev/null
> > +++ b/tools/testing/cxl/uunit/app/core_region_ut.c
> > @@ -0,0 +1,237 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "pre.h"
> > +#include "drivers/cxl/core/region.c"
> > +#include "post.h"
> > +#include "../stub.c"
> > +
> > +#include <CUnit/Basic.h>
> > +#include <stdlib.h>
> > +
> > +DECLARE_RWSEM(cxl_dpa_rwsem);
>=20
> This is here because core_region_ut.c is not allowed to use stubs
> core_hdm_ut.c?

Correct. This will be fixed in v2 with the changes I referenced above.

> > +	resource.start =3D 0x1000000000;
> > +	resource.end =3D   0x2000000000;
>=20
> Spotted this just because of the recent debug adventure here:
>=20
> http://lore.kernel.org/r/6595c10982cf_8dc6829433@dwillia2-xfh.jf.intel.co=
m.notmuch
>=20
> ...where that resource.end should be the exclusive "end" of 0x1fffffffff

Ack.

> [..]
> > diff --git a/tools/testing/cxl/uunit/include/post.h b/tools/testing/cxl=
/uunit/include/post.h
> > new file mode 100644
> > index 000000000000..231f5bc15c3a
> > --- /dev/null
> > +++ b/tools/testing/cxl/uunit/include/post.h
> [..]
> > diff --git a/tools/testing/cxl/uunit/include/pre.h b/tools/testing/cxl/=
uunit/include/pre.h
> > new file mode 100644
> > index 000000000000..1eb88e51740f
> > --- /dev/null
> > +++ b/tools/testing/cxl/uunit/include/pre.h
>=20
> These last 2 files look like a lot of hard fought meticulous magic,
> hence the question above about expected ongoing maintenance burden.

See above. But some extra comments around this wouldn't hurt - I'll add tha=
t
in v2.

> > diff --git a/tools/testing/cxl/uunit/stub.c b/tools/testing/cxl/uunit/s=
tub.c
> > new file mode 100644
> > index 000000000000..208dab1e7d6d
> > --- /dev/null
> > +++ b/tools/testing/cxl/uunit/stub.c
>=20
> It might be worthwhile to let clang-format do a once over on this and all
> the other files if only to keep the automated coding-style bots from
> tripping on these files.

The formatting is horrible. I need to clean this up and will run clang-form=
at
before sending out the v2.

-Jim=
