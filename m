Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901EAA35;
	Thu, 15 Aug 2024 01:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723684418; cv=none; b=O6fckBZskVYczZYqd1jH5gHbU2NC+R2/b9UvlikQfShyB1koVPeZ+bIDDm75SkZ8G9Hfq68/JtzIUKQibcHQWxdrtlC0Uzf58CQaSiHc2C6Sz00gNvYD8mkK0ENHfigLlqVWCoeQZM7dp4mQ+qtvzhCoYs03s3RehWngLTTxV1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723684418; c=relaxed/simple;
	bh=rTawv10ThaNtV9PGUAG/yHY9BSoQJmH+hsFuxUoVYsk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kGIbHoRQFZLBVRFVa6TxOhamep2962JgyLFIo8WLUYizypRPztEns02TMKUScepwcBlX1Qvnjy2gNN92qftFwCHKHKj/twkxtdHX3fI++70u2KhTVPwx/7TyJuROnzugfsuyprvfldA62eVpTPTvWmjiRBhhy1T/39iq6IcjlAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dy58k/dT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dy58k/dT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723684417; x=1755220417;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=rTawv10ThaNtV9PGUAG/yHY9BSoQJmH+hsFuxUoVYsk=;
  b=dy58k/dTP5Fluj2XdezW1ABr7eBeuRZP5hpgQUaJADobNkN1JztwD37g
   aax8vgJMtbJ2u/ZbQ9YYeAMKUSf+9vXez116mtTgDv6yg9FI1UdlYBTcz
   dDEoBJcFZ9JwkjsK/VjngiZLcM02jcED/bicYkTb6RiMr5ld0i15VlWK4
   L7ZW027I/9ewFFrGJqMJyyxE2GOaUFOOzTrNFIl9el/PYq0bOIVld64ol
   HX9abTiHejTUfjYL+A0E7IrQ4dMrfJEvjvrVdd5t/gTrej+j0zIhHFa77
   r3pvIsfOOeCp3lHwnTiI87I3y2/JkHgCpPVWDl4OZizhcA8zPtq/+rQP+
   Q==;
X-CSE-ConnectionGUID: igI532nJQd6aPjMMOO+ipg==
X-CSE-MsgGUID: xw9T8romQ42oDrmL8ihIBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="22081867"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="22081867"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 18:13:36 -0700
X-CSE-ConnectionGUID: 7cj9iZDNRNCs/LMRWoqzfQ==
X-CSE-MsgGUID: AXp1KBdFSNqAaW4w8o1gHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="59208141"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 18:13:33 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,  Dan Williams
 <dan.j.williams@intel.com>,  Dave Jiang <dave.jiang@intel.com>,
  <linux-cxl@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,  Davidlohr
 Bueso <dave@stgolabs.net>,  "Alison Schofield"
 <alison.schofield@intel.com>,  Vishal Verma <vishal.l.verma@intel.com>,
  Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 3/3] cxl: Avoid to create dax regions for type2
 accelerators
In-Reply-To: <cba1752a-0b0d-0df0-8526-aed25d81ed3a@amd.com> (Alejandro Lucero
	Palau's message of "Mon, 12 Aug 2024 12:54:57 +0100")
References: <20240729084611.502889-1-ying.huang@intel.com>
	<20240729084611.502889-4-ying.huang@intel.com>
	<20240804173813.00001018@Huawei.com>
	<87v80e9p0m.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<cba1752a-0b0d-0df0-8526-aed25d81ed3a@amd.com>
Date: Thu, 15 Aug 2024 09:10:00 +0800
Message-ID: <87a5hek2vr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Alejandro Lucero Palau <alucerop@amd.com> writes:

> On 8/6/24 06:52, Huang, Ying wrote:
>> Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
>>
>>> On Mon, 29 Jul 2024 16:46:11 +0800
>>> Huang Ying <ying.huang@intel.com> wrote:
>>>
>>>> The memory range of a type2 accelerator should be managed by the type2
>>>> accelerator specific driver instead of the common dax region drivers,
>>>> as discussed in [1].
>>>>
>>>> [1] https://lore.kernel.org/linux-cxl/66469ff1b8fbc_2c2629427@dwillia2-xfh.jf.intel.com.notmuch/
>>>>
>>>> So, in this patch, we skip dax regions creation for type2 accelerator
>>>> device memory regions.
>>>>
>>>> Based on: https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>>>
>>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>>>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>>>> Cc: Dave Jiang <dave.jiang@intel.com>
>>>> Cc: Alison Schofield <alison.schofield@intel.com>
>>>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>>>> Cc: Ira Weiny <ira.weiny@intel.com>
>>>> Cc: Alejandro Lucero <alucerop@amd.com>
>>>> ---
>>>>   drivers/cxl/core/region.c | 8 ++++++++
>>>>   1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>> index 9a483c8a32fd..b37e12bb4a35 100644
>>>> --- a/drivers/cxl/core/region.c
>>>> +++ b/drivers/cxl/core/region.c
>>>> @@ -3435,6 +3435,14 @@ static int cxl_region_probe(struct device *dev)
>>>>   					p->res->start, p->res->end, cxlr,
>>>>   					is_system_ram) > 0)
>>>>   			return 0;
>>>> +		/*
>>>> +		 * HDM-D[B] (device-memory) regions have accelerator
>>>> +		 * specific usage, skip device-dax registration.
>>>> +		 */
>>>> +		if (cxlr->type == CXL_DECODER_DEVMEM)
>>>> +			return 0;
>>> As in previous need to be careful as that may not mean it's
>>> an accelerator.
>> Yes.  We need some other way to identify type2 devices.
>
>
> Maybe the easier option is the accel driver specifying if DAX should
> be used.
>
> We are adding mailbox and hdm as optional for accel/type2, with the
> driver specifying what is supported. Another optional param could be
> this DAX usage.

Another way is let accel/cxl_pci driver specify the device type (type2
vs. type3).  cxl_pci_probe()->cxl_memdev_state_create() will set
cxl_dev_state.type = CXL_DEVTYPE_CLASSMEM. And
accel_X_probe()->cxl_accel_state_create() can set cxl_dev_state.type =
CXL_DEVTYPE_DEVMEM.  This can be passed to cxl_region.  Then we can
create cxl_dax_region for type3 devices only by default.

>
>>> However, we do need to deal with BI setup for HDM-DB type 3 devices
>>> etc and to check the HDM Decoder capability registers to make sure
>>> Supported Coherence model is appropriate. (e.g. 11 for host only or
>>> device coherency - HDM-H/HDM-DB)
>> Yes.  We need to check BI configuration too.
>>
>>>> +
>>>> +		/* HDM-H routes to device-dax */
>>>>   		return devm_cxl_add_dax_region(cxlr);
>>>>   	default:
>>>>   		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",

--
Best Regards,
Huang, Ying
