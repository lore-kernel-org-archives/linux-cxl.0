Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D372173326;
	Fri, 18 Oct 2024 06:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729232544; cv=none; b=dM/ucwGNYlwXQXkiIiTDgM1H2aeRF6XrkVEyIKRE8PubbZ7dX4tEV6JlWLAYRgdFohxcS5n0Nu1WP2IXUoU3ltm9NSULuG/iVAHSm0UjPMJGhJLFjB/D9/aSi2MN/rfzP6voKWQEeL/n6zCCb5761QX56g8bvVKU63uyd8pJias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729232544; c=relaxed/simple;
	bh=IqLzXohJX66D2JZCurgrTzPtyopB1LzzrsvhGh3Zs9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O0cZX4pwGrS9uT/5ToyP+Lssdv1gAvClhNIvn0jXJGYrzEwoW59wZevga7DBisEwigBWBWxRJilss+Oa2Vl7tJPuM296bb9jx6EeZ75NdTOpBLI6PUmfl3EJ99LKQ2KV7z7UgefbY0a5VlOy+sRUf4YiKjyK9gu7ZVbddxElkH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOkGVZal; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOkGVZal"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729232543; x=1760768543;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=IqLzXohJX66D2JZCurgrTzPtyopB1LzzrsvhGh3Zs9c=;
  b=OOkGVZaleFfZ6GR6YcjNwGLjkqFfOrvb+AxFm6nDt5G/98gcGTJTe47i
   Zv99X48WcN5SimrlnlaDMEJgQ9WIjM3ycZ7lXiU5AfUcR3R/bnGkuIOgz
   cRTz1k2NBLLhsByCHWt5Xe/MpdHHgonBJncszwTxaCu2Ycm0xls+yjLjQ
   4VW4Znmxb/52ggtOHqNOu1Fnn/+fKEo0ob0Kk9yNBNJ2FAFM7Ombxnkik
   8qJEGiIGyzG2kacg//UcejUOJaxbA1/Stg7pP3rPYtPqRGTGaaa9kWMJN
   D84c8Lfv1FS02uAb+D3tMosLSEkY3tZ2rUbXc2mhKFOR1JERLrnob90pd
   A==;
X-CSE-ConnectionGUID: WsJ2c/l4S/Gf7VwCkGOmoA==
X-CSE-MsgGUID: hLpBbT6gRTaxIJzpF0QQqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="39340234"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="39340234"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:22:22 -0700
X-CSE-ConnectionGUID: StR5ZspeTJuSkuNWioar0w==
X-CSE-MsgGUID: mG8QVoyIRsOwn+kAvkzxCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78438998"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:22:19 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,  linux-cxl@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Davidlohr Bueso <dave@stgolabs.net>,
  Gregory Price <gourry@gourry.net>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  Alison Schofield
 <alison.schofield@intel.com>,  Vishal Verma <vishal.l.verma@intel.com>,
  Ira Weiny <ira.weiny@intel.com>,  Alejandro Lucero <alucerop@amd.com>,
  Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 2/5] cxl: Rename CXL_DECODER_HOSTONLYMEM/DEVMEM
In-Reply-To: <67118dcd2ba4a_3f14294fe@dwillia2-xfh.jf.intel.com.notmuch> (Dan
	Williams's message of "Thu, 17 Oct 2024 15:21:01 -0700")
References: <20241015065713.308671-1-ying.huang@intel.com>
	<20241015065713.308671-3-ying.huang@intel.com>
	<67118dcd2ba4a_3f14294fe@dwillia2-xfh.jf.intel.com.notmuch>
Date: Fri, 18 Oct 2024 14:18:47 +0800
Message-ID: <87bjzi6iig.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Dan,

Dan Williams <dan.j.williams@intel.com> writes:

> Huang Ying wrote:
>> Previously, CXL type3 devices (memory expanders) use host only
>> coherence (HDM-H), while CXL type2 devices (accelerators) use dev
>> coherence (HDM-D).  So the name of the target device type of a cxl
>> decoder is CXL_DECODER_HOSTONLYMEM for type3 devices and
>> CXL_DECODER_DEVMEM for type2 devices.  However, this isn't true
>> anymore.  CXL type3 devices can use dev coherence + back
>> invalidation (HDM-DB) too.
>> 
>> To avoid confusion between the device type and coherence, the patch
>> renames CXL_DECODER_HOSTONLYMEM/DEVMEM to CXL_DECODER_EXPANDER/ACCEL.
>
> This does not look like an improvement to me. Type-3 devices that
> support back-invalidate are DEVMEM devices. The device plays a role in
> the coherence. 
>
> Your explanation is the reverse of this commit:
>
> 5aa39a9165cf cxl/port: Rename CXL_DECODER_{EXPANDER, ACCELERATOR} => {HOSTONLYMEM, DEVMEM}
>
> ...so I am confused what motivated this rename?

Sorry, I am confused about the target_type and coherence and forgot to
check the history.  In some places, current kernel still hints
target_type (CXL_DECODER_HOSTONLYMEM/DEVMEM) as expander/accelerator.
Should we change them to avoid confusion in the future?

$ grep expander -r drivers/cxl/
drivers/cxl/cxl.h:346: * @target_type: accelerator vs expander (type2 vs type3) selector
drivers/cxl/core/region.c:2450: * @type: select whether this is an expander or accelerator (type-2 or type-3)
drivers/cxl/core/port.c:141:		return sysfs_emit(buf, "expander\n");

The last one is

static ssize_t target_type_show(struct device *dev,
				struct device_attribute *attr, char *buf)
{
	struct cxl_decoder *cxld = to_cxl_decoder(dev);

	switch (cxld->target_type) {
	case CXL_DECODER_DEVMEM:
		return sysfs_emit(buf, "accelerator\n");
	case CXL_DECODER_HOSTONLYMEM:
		return sysfs_emit(buf, "expander\n");
	}
	return -ENXIO;
}
static DEVICE_ATTR_RO(target_type);

for decoder device.  This is a testing ABI documented in,

Documentation/ABI/testing/sysfs-bus-cxl

Is it OK to change this?

--
Best Regards,
Huang, Ying
