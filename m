Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EC12E11B5
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749835000; cv=none; b=b4HhytUxJ4PkyjMVbEG+w9d/9uwxQQnlweD2KO1KX1nRAEykUI0w+9e0xjyYxUNQbWnkJlbIkxfSrGvF7ilNkLm9lIcu4CsRS9nE1IrdJOsEeXIJCYZi1ub6l0YvPhV+J4Lg9ov8O7t0VVJOpQFTsuEBQfp4pJQVdlgFrwOb4qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749835000; c=relaxed/simple;
	bh=a8Mh3z1jdDmpZZqFvWHFwsDa0rnFnBFNde56Tn7k7Xc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGaoZW8nQnlI+u9GoBEeoY70UrDqdYsJkLe7YWtrER8W4zDgZ1PQORS4PY11+vv4RPxoJiePRRcJP5MnzI5HcFbrkTSPf9r+bIPwZhc31IWpIi64r9f0iyHgbn5UM9/OFXhsSDG1qVFhl9kxgeuLITd/Po71Qty/RL2EvCQ/x5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJmJQ0rC8z6M4sr;
	Sat, 14 Jun 2025 01:16:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A47B2140371;
	Sat, 14 Jun 2025 01:16:33 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Jun
 2025 19:16:33 +0200
Date: Fri, 13 Jun 2025 18:16:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, <mst@redhat.com>,
	Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama
	<itaru.kitayama@linux.dev>, <linuxarm@huawei.com>,
	<linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
	<philmd@linaro.org>, Alireza Sanaee <alireza.sanaee@huawei.com>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v15 4/4] qtest/cxl: Add aarch64 virt test for CXL
Message-ID: <20250613181631.00000336@huawei.com>
In-Reply-To: <CAFEAcA8xVQUnReg-3jYENLmOMG_PeJ-ACLQa0dRoLBzxQ+9Svg@mail.gmail.com>
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
	<20250612134338.1871023-5-Jonathan.Cameron@huawei.com>
	<CAFEAcA8xVQUnReg-3jYENLmOMG_PeJ-ACLQa0dRoLBzxQ+9Svg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 13 Jun 2025 13:32:03 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 12 Jun 2025 at 14:45, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > Add a single complex case for aarch64 virt machine.
> > Given existing much more comprehensive tests for x86 cover the
> > common functionality, a single test should be enough to verify
> > that the aarch64 part continue to work.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > ---
> > v15: Dropped tags due to changes in patches 2 and 3.
> > ---
> >  tests/qtest/cxl-test.c  | 59 ++++++++++++++++++++++++++++++++---------
> >  tests/qtest/meson.build |  1 +
> >  2 files changed, 47 insertions(+), 13 deletions(-)
> >
> > diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> > index a600331843..c7189d6222 100644
> > --- a/tests/qtest/cxl-test.c
> > +++ b/tests/qtest/cxl-test.c
> > @@ -19,6 +19,12 @@
> >      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
> >      "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
> >
> > +#define QEMU_VIRT_2PXB_CMD \
> > +    "-machine virt,cxl=on -cpu max " \
> > +    "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
> > +    "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
> > +    "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
> > +
> >  #define QEMU_RP \
> >      "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
> >
> > @@ -197,25 +203,52 @@ static void cxl_2pxb_4rp_4t3d(void)
> >      qtest_end();
> >      rmdir(tmpfs);
> >  }
> > +
> > +static void cxl_virt_2pxb_4rp_4t3d(void)
> > +{
> > +    g_autoptr(GString) cmdline = g_string_new(NULL);
> > +    char template[] = "/tmp/cxl-test-XXXXXX";
> > +    const char *tmpfs;
> > +
> > +    tmpfs = mkdtemp(template);  
> 
> We prefer g_mkdtemp() or g_dir_make_temp() over raw mkdtemp(),
> I think. Other tests in this file use g_dir_make_tmp().

Ah. I'd failed to update this when various people cleaned up the other
tests.  Your comments reflect that earlier cleanup so I'll update
this to match the other tests.

> 
> Also you aren't checking whether it failed.
> 
> > +
> > +    g_string_printf(cmdline, QEMU_VIRT_2PXB_CMD QEMU_4RP QEMU_4T3D,
> > +                    tmpfs, tmpfs, tmpfs, tmpfs, tmpfs, tmpfs,
> > +                    tmpfs, tmpfs);
> > +
> > +    qtest_start(cmdline->str);  
> 
> We never change the GString and only use its C representation,
> so I think it's simpler to use
>   g_autofree char *cmdline = NULL;
>   ...
>   cmdline = g_strdup_printf(...);
> 
> But I see all the other tests in this file are written this
> way, so I'm ok with staying consistent to that here.

I'll stick to matching the others.

> 
> -- PMM

