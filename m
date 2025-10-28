Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3CF32ABC3;
	Tue, 28 Oct 2025 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661659; cv=none; b=iWkxdMissn8bzyN8X0JropzlBIyY2DLG9n0ZZ4k3mr6Salozbq37Y7MPDgw8BBLSJ1yzHhlivjM/tgPzwOXe4oMDz7DP1RI453c7zcOwgedn8xY8jQkkORJLFkov2iK/qKggQopG5FHfwtaT9MGU5w6nT/T034z7B9qvJtqO9/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661659; c=relaxed/simple;
	bh=HN5gCjWcl53Q/ofqMQ8gWafIhNFC/61P7jhn3tzFMt8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phqGRFwXyLdmOHSBg7hkSQo/9HqN4esOykGlN6QNHHviYEfNgnwRxZ8fQYma1C+hTFQsGwFSwIGTaJ5NLPtYsAarHPgwd6MSwuhBc57wK7b0oVteUbc0gUHA3qqB00oLYGOulVuBby498wJb5c9/ol7RLFYGpj4UeL2vaTOuv8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cwt3g3RTzzHnGf5;
	Tue, 28 Oct 2025 14:26:39 +0000 (UTC)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 354B81400D3;
	Tue, 28 Oct 2025 22:27:30 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 14:27:29 +0000
Date: Tue, 28 Oct 2025 14:27:27 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Terry
 Bowman" <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH] cxl/region: Support multi-level interleaving with
 smaller granularities for lower levels
Message-ID: <20251028142727.00003f91@huawei.com>
In-Reply-To: <20251028094754.72816-1-rrichter@amd.com>
References: <20251028094754.72816-1-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 28 Oct 2025 10:47:53 +0100
Robert Richter <rrichter@amd.com> wrote:

> The CXL specification supports multi-level interleaving "as long as
> all the levels use different, but consecutive, HPA bits to select the
> target and no Interleave Set has more than 8 devices" (from 3.2).
> 
> Currently the kernel expects that a decoder's "interleave granularity
> is a multiple of @parent_port granularity". That is, the granularity
> of a lower level is bigger than those of the parent and uses the outer
> HPA bits as selector. It works e.g. for the following 8-way config:
> 
>  * cross-link (cross-hostbridge config in CFMWS):
>    * 4-way
>    * 256 granularity
>    * Selector: HPA[8:9]
>  * sub-link (CXL Host bridge config of the HDM):
>    * 2-way
>    * 1024 granularity
>    * Selector: HPA[10]
> 
> Now, if the outer HPA bits are used for the cross-hostbridge, an 8-way
> config could look like this:
> 
>  * cross-link (cross-hostbridge config in CFMWS):
>    * 4-way
>    * 512 granularity
>    * Selector: HPA[9:10]
>  * sub-link (CXL Host bridge config of the HDM):
>    * 2-way
>    * 256 granularity
>    * Selector: HPA[8]
> 
> The enumeration of decoders for this configuration fails then with
> following error:
> 
>  cxl region0: pci0000:00:port1 cxl_port_setup_targets expected iw: 2 ig: 1024 [mem 0x10000000000-0x1ffffffffff flags 0x200]
>  cxl region0: pci0000:00:port1 cxl_port_setup_targets got iw: 2 ig: 256 state: enabled 0x10000000000:0x1ffffffffff
>  cxl_port endpoint12: failed to attach decoder12.0 to region0: -6
> 
> Note that this happens only if firmware is setting up the decoders
> (CXL_REGION_F_AUTO). For userspace region assembly the granularities
> are chosen to increase from root down to the lower levels. That is,
> outer HPA bits are always used for lower interleaving levels.
> 
> Rework the implementation to also support multi-level interleaving
> with smaller granularities for lower levels. Determine the interleave
> set of autodetected decoders. Check that it is a subset of the root
> interleave.
> 
> The HPA selector bits are extracted for all decoders of the set and
> checked that there is no overlap and bits are consecutive. All
> decoders can be programmed now to use any bit range within the
> region's target selector.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

We debated this back when the original support was added. At the time the
discussion pretty much concluded there was no reason anyone would ever actually
do this because it mostly doesn't provide much/any performance benefit and
might result in significantly worse performance by not spreading out accesses as
early as possible.

So do we have any idea why a bios is doing this? Something about the
host interconnect?

Thanks,

Jonathan

