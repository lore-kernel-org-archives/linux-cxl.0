Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E09390CB7
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792191047; cv=none; b=Nbc67MmEXFuWmWLbW3rdqTlCw9KhUSUUmWG3GtN9lDq3N5hhdNeOqAO3DLjajhZ6i2m4o1SNTzow7rud8XBQLlsDauguthGrpNllN7RAjD8t8uYxBmdl0z5BG45+bVdxraXRe4KGuWmiDPELeU9U9bnza4aC0QInnsvDuBvaqKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792191047; c=relaxed/simple;
	bh=NuYmhzfdONwdRSQnWu38SkqViya+1tJIaIFAH3qLHCc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejdY8sKGsVotde9MZpVhgt65OFoQqybmRkYV3wzqKsPbiEnsXSHJYpTnXKDwfhGJbcwiM/4JOW8YpmiWhK7w0ZuOez1BL7KDwf2Rz158jzgi+rOspGq36veKzx7Qz3UDnXorwcBnHHboC9Ht5xmwcc4YebeQkdrCFy7pMlntUd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csgHvGnq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csgHvGnq"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8520161fdb9so243485b3a.3
        for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 15:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792191045; x=1792795845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C6NovYbnordr8tqJujtgwBLctkW+zVn2MQqMxfmRhTo=;
        b=csgHvGnqGewobaJOJpvyFOyWZiQitobyvqmegcDpxWfUsCtCV9dEHApWT1IIZ6goxs
         +duMywjsCr+IOcBeg9DipJhjX+EavvCEN+O0v2g4N94NttlEmP8glTZ4xnWaE3UQFVGs
         hV+MaXfobm+YnBNMikpIWB+lK/ohc2/QF4YEjg+ojwN0TyQjwJZCfHLfd7t7a2+6rM5g
         prbSd3m0nptnrrpFWqcOkrsQuphxhpGxCMFCEOh+HmxdE63JAfLmujiIJhZXpgi2F2U2
         QMgrQU0+QUQjMKT8XlQSN5f8H28K9tz2u4D2JKPSyQOSLMQqnkESo/XpwOersOxf3yzj
         ZS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792191045; x=1792795845;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C6NovYbnordr8tqJujtgwBLctkW+zVn2MQqMxfmRhTo=;
        b=vAGXO1ZFLAHv6QvbS5RCqTaRjdzYft4AumX8y7ytpDvscdtTEC8gsMA/1YxyQUCsT6
         M0AIANhJjhnLgf5ahJZ30b9pHKZD/VVzb/3D46TYoHjmXM6t4qajZVpKjBQpk4ctv+fn
         jc20VQ5g9HXLhH5qtX8frptxockQbJIDp6SdgnumbU4/F7/uvsg10R1DQo886aApde5b
         oXhFFJkPH4BBiPIECQ/sKKcUIAidfpoUiPWOZJbxmcym9AindnDVRzNBJAUw5gtvJ4pP
         cTS23m0BmR34kGXLmsDHFs+blpC4ZlfFygS7YrfqlumVHkUzFJWZGs1GaGLhH8i0bnuh
         7IeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwl7iCmRKyZ8HBiE59RH4RthmrC/3vdruIbdmDb5TxpQZNSbPVVFKceAJtsOH3gNCimsEMFJLOMUo8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5gF2elHn/+ZAZjULCWtH9c856bAPJ2qg8P5jSBTCuE32G//Nv
	qTsOglCOPQGyE2GulTp3Ua5rwk/wNFcRn8HfjaLsRTvTHok1UnESJMVg
X-Gm-Gg: AYBFou1CqTz5Oqkx9tq3v30CHzkv1A4NkUZ7mkY6ln+aMDk4xu5Q3nqsPuXe0ymOP+U
	iR/uvJQNGK4WpmhTOFFH2P88y1aP9evEIo6qg+QPtdkG8cRCL+uX3kaag4mHAG4Kk1rErakHxGz
	l0H3+SyKhg95ECFe2bEubU/Q793Tk6hsXlgyd3+bnYi/fpre6fFpQmavyL7J614IIpEJ6rKR/kr
	e5Rq2vkJIUWJjl1CNYnZpMm2Rv+h45s51Uk8d+NYr/NCIV675RGxOhp5xpJkKCG2L6R9bKjIoVz
	051KKUGdIHLoIxNorVV9xWDVCivD5u+RrY/eKSw84q50CsblxWwQS2UGq+nwgqL4jGAi+dx2fST
	k7VxHjeh3iGdjnO1YhQo9enlYVTYGmJz41fAxElkSWQtQsoY1BxeKJw3gqmnw7hzIV557l9jvTM
	ifEXvRbYi1SOgngmMhzY1f7eWMMYDhw7IZT4rrOTi0bepHbSOBLePomVCZ5+XnBxxIN++YxMCOW
	tqLWEgl6XQnHlEldLi1UnWIgA==
X-Received: by 2002:a05:6a00:4c93:b0:89e:6bef:70f9 with SMTP id d2e1a72fcca58-8a04cb16908mr702558b3a.27.1792191045267;
        Fri, 16 Oct 2026 15:50:45 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f58408085sm1738433b3a.55.2026.10.16.15.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 15:50:44 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Sat, 17 Oct 2026 07:52:29 +0900
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/4] Documentation/driver-api/cxl: Add a testing page
Message-ID: <atKqrRww5GlgzRlA@cxlqual>
References: <cover.1791949910.git.alison.schofield@intel.com>
 <7af9e1341a24928799d88adaa6144c1ca82091f7.1791949910.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7af9e1341a24928799d88adaa6144c1ca82091f7.1791949910.git.alison.schofield@intel.com>

On Tue, Oct 13, 2026 at 09:17:52PM -0700, Alison Schofield wrote:
> The CXL documentation does not describe the subsystem's testing
> infrastructure or provide guidance on choosing between cxl_test
> and KUnit.
> 
> Add a testing page that describes when to use each framework, how
> to run the tests, and how to add a CXL KUnit test.
> 
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  Documentation/driver-api/cxl/index.rst   |   1 +
>  Documentation/driver-api/cxl/testing.rst | 117 +++++++++++++++++++++++
>  2 files changed, 118 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/testing.rst
> 
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index 3dfae1d310ca..786c189366ca 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -15,6 +15,7 @@ that have impacts on each other.  The docs here break up configurations steps.
>     theory-of-operation
>     maturity-map
>     conventions
> +   testing
>  
>  .. toctree::
>     :maxdepth: 2
> diff --git a/Documentation/driver-api/cxl/testing.rst b/Documentation/driver-api/cxl/testing.rst
> new file mode 100644
> index 000000000000..e3e2613172a2
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/testing.rst
> @@ -0,0 +1,117 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========
> +Testing CXL
> +===========
> +
> +CXL testing uses two complementary frameworks: cxl_test exercises the driver
> +stack against an emulated CXL topology, while KUnit tests self-contained logic
> +in isolation. Changes should preserve existing test coverage and extend the
> +framework appropriate to the behavior being changed.
> +
> +cxl_test
> +========
> +
> +The cxl_test modules, built from tools/testing/cxl/, emulate a CXL topology with
> +host bridges, switches, memory devices, and mailboxes. This allows the CXL driver
> +stack to be tested without hardware. The tests are maintained in the ndctl repo
> +at https://github.com/pmem/ndctl, under test/cxl-<name>.sh.
> +
> +Use cxl_test for behavior that depends on a live topology: port and endpoint
> +enumeration, region creation and assembly, decoder commit, and anything that
> +crosses the sysfs ABI.
> +
> +Build the cxl_test modules from the top of the kernel tree::
> +
> +  make M=tools/testing/cxl
> +
> +After installing the modules for the running kernel, run the CXL suite from an
> +ndctl build::
> +
> +  meson test -C build --suite cxl
> +
> +For more on building and running the ndctl unit tests, see:
> +
> +- the Unit Tests section of the ndctl README,
> +  https://github.com/pmem/ndctl?tab=readme-ov-file#unit-tests
> +- the ndctl test runner,
> +  https://github.com/pmem/ndctl-test-runner?tab=readme-ov-file#ndctl-test-runner
> +
> +
> +KUnit
> +=====
> +
> +KUnit tests run self-contained logic in the kernel without any CXL topology.
> +KUnit is suited to logic that can be exercised with controlled test inputs,
> +including encode/decode helpers, address translation and interleave calculations,
> +parsers of device- or firmware-supplied data, and mailbox command handling
> +through a stub transport.
> +
> +To run all of the CXL KUnit tests, from the top of the kernel tree::
> +
> +  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/cxl
> +
> +This builds a test kernel in .kunit/ using drivers/cxl/.kunitconfig and runs it
> +under User Mode Linux (UML). The running kernel is not modified, and no
> +installation is required. The test kernel runs the tests, reports the results,
> +and exits.
> +
> +Add --arch=x86_64 to run the tests under QEMU instead.
> +
Add --arch=<arch> ...
Maybe also point at "--arch=help"

Reviewed-by: Anisa Su <anisa.su@samsung.com>
> +Running during development
> +--------------------------
> +
> +kunit.py builds in .kunit/, but kbuild does not allow an out-of-tree build when
> +the source tree already contains an in-tree build. If you build the kernel
> +in-tree, use a separate worktree for KUnit. The worktree contains the committed
> +sources at the selected revision::
> +
> +  git worktree add ../linux-kunit HEAD
> +  cd ../linux-kunit
> +  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/cxl
> +
> +To run a single suite, name it::
> +
> +  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/cxl cxl_core_mbox
> +
> +Enable KASAN when testing memory safety error paths. It can detect an out-of-bounds
> +access even when the resulting value does not cause a test assertion to fail::
> +
> +  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/cxl \
> +      --arch=x86_64 --kconfig_add CONFIG_KASAN=y
> +
> +Adding a KUnit test
> +-------------------
> +
> +A CXL KUnit test follows these rules:
> +
> +- Place the test in a tests/ directory beside the code under test, in a
> +  file named <name>_kunit.c.
> +
> +- Derive the module and suite names from the path below drivers/cxl/, excluding
> +  tests/. For example, drivers/cxl/core/tests/port_kunit.c produces module
> +  cxl_core_port_kunit and suite cxl_core_port, while drivers/cxl/tests/port_kunit.c
> +  produces module cxl_port_kunit and suite cxl_port.
> +
> +- Build new suites under CONFIG_CXL_KUNIT_TEST rather than introducing a separate
> +  Kconfig option for each suite. Individual suites can be selected by name with
> +  kunit.py or by loading their module.
> +
> +- If the code under test depends on another configuration option, such as
> +  CONFIG_CXL_REGION, make the test build conditional on that option in tests/Makefile
> +  and enable it in drivers/cxl/.kunitconfig.
> +
> +- Use exported interfaces where possible, importing the CXL symbol namespace as needed.
> +
> +When to add a test
> +==================
> +
> +New or modified self-contained logic should be accompanied by KUnit coverage where
> +practical. Extend an existing suite when possible, or introduce a new one for
> +functionality that is not yet covered.
> +
> +Bug fixes should include regression coverage that reproduces the problem without
> +the fix.
> +
> +Changes to topology-dependent behavior should be covered by cxl_test tests in ndctl.
> +KUnit coverage complements, but does not replace, cxl_test.
> -- 
> 2.37.3
> 
