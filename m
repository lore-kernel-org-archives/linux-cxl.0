Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D7B3559E6
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802468; cv=none; b=Q7efP0tgMutYhxx+TIO2LZVYuclC7PbUoaRS1L1GkZlNzrWgkLQPyiBXugMRgmVq5JQoykI+Tmjxe1Gd8cjMxfla65IPvckTwAE7PlgdEKZMtGPiEeEeL9PUUyk2XrL3cGKgFN7SNbf8PKA1RPZzsKH0obEKspRnlT/3hMf5DWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802468; c=relaxed/simple;
	bh=gVYsCtzVKye+VpRsilt5pop7MV8XugWUZXaw4t/x09c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cx79dwI7ctxVpdNhHtg3U7jIK9vCEHiEWv1gsJXeDn+JjlvNIZL15yG/RGh/MTeT0Jl4UtSTaW2PsDTk0ZFQEd5Xa9E2c76ELHFUAazRpa3xXgMVKe/fYRxG3qWUO8ywQ5ZHS/lp8lNfGBqyq3noLHRdlEJCfRmhAdnA0ndW8Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f9tXB11FrzJ46BH;
	Wed, 11 Feb 2026 17:33:14 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CD5840086;
	Wed, 11 Feb 2026 17:34:14 +0800 (CST)
Received: from localhost (10.47.78.166) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 11 Feb
 2026 09:34:13 +0000
Date: Wed, 11 Feb 2026 09:34:09 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: Anisa Su <anisa.su887@gmail.com>
CC: Ira Weiny <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>,
	<dongjoo.seo1@samsung.com>
Subject: Re: [RFC PATCH 0/3] Add Support for Multiple DC Regions
Message-ID: <20260211093409.00002239.alireza.sanaee@huawei.com>
In-Reply-To: <aYve5vj6sQ4QjiBa@4470NRD-ASU.ssi.samsung.com>
References: <20251203203540.1091827-1-anisa.su887@gmail.com>
	<6931c4c85a526_43de3100bb@iweiny-mobl.notmuch>
	<aTsyJXKnL0SA1hl-@deb-101020-bm01.eng.stellus.in>
	<693c922448bbc_c04a9100eb@iweiny-mobl.notmuch>
	<aWV0e03pP4hfqkLo@4470NRD-ASU.ssi.samsung.com>
	<20260115102819.00006d55.alireza.sanaee@huawei.com>
	<aYve5vj6sQ4QjiBa@4470NRD-ASU.ssi.samsung.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 10 Feb 2026 17:44:06 -0800
Anisa Su <anisa.su887@gmail.com> wrote:

> On Thu, Jan 15, 2026 at 10:28:19AM +0000, Alireza Sanaee wrote:
> > On Mon, 12 Jan 2026 14:23:55 -0800
> > Anisa Su <anisa.su887@gmail.com> wrote:
> > 
> > Hi Anisa,
> >   
> [snip] 
> > > Sounds good. For RC2, I'll keep it simple and just rebase + bug fixes.  
> > Thanks Anisa. I was also about to look into the rebasing as well.  
> Hey sorry for the delay! I've rebased on cxl-next: https://github.com/anisa-su993/anisa-linux-kernel/tree/dcd-v10-2026-02-09
Oh nice! Thanks Anisa.
> 
> I tested basic add/remove and region/dax device creation with QEMU, but didn't
> spend too much time testing as the bug fixes were quite small.
> 
> The bug fixes + who they were suggested by are tracked at the end of the commit
> message :)
> 
> Thanks,
> Anisa

