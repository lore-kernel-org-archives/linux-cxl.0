Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115A964A;
	Mon, 21 Oct 2024 04:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729485865; cv=none; b=r9XDSTdJoxsry0R6Sztz7FawD5xzdpGN/vzx+DA7hxVgS3P2M2QCV2+9R6vjBkQdioYqoC63G7Z4bhYiIPi6/6881RK4x3DZEEBjtK2xK0kw9j9drPX81bl+2SM/dev1ohhhFP9iiGeq5dncHYGRHUISQGyKqsKh/En+RUd6mko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729485865; c=relaxed/simple;
	bh=AOXTHP1ex+E1EjvhhyRyoOh0uTiIU0JTYVltxXeKFW0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V84dRWm+o21pdt773NhzyGgYIgZOpFlxv4WiWMBiecJ/QOIY4+pyqvbkPpfroY3QDnIGc1o/33RPnecmcibi7kNWjLsOgfJIKwNBWbhopuckZY4v33OHVMM0n/oYDHlm4hpDr7OYW2612NZx1gvEmvbiEw+d7nqhLsgsA+H4ZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOpZLuok; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOpZLuok"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729485863; x=1761021863;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=AOXTHP1ex+E1EjvhhyRyoOh0uTiIU0JTYVltxXeKFW0=;
  b=QOpZLuok7vG1pX2sknlBkxlU09hV9Vxf9z248xtBjNrpJSorcvhdX4C3
   yCVfbFdKh7VPXGfwpG9/odpfI3MvqY4mjVklO3RJaP/uhW3RmJS8CN+/E
   Xcmwz33WBs9/G5MOqohcmHC0Tt6oLbWZSKXk71AWV4UTqZdg7URmXQ9oT
   5W9vsqBUGRAXn9+SOX63URpacaDy/QuS+DFQU8vE3UOU5eZeZGfGbBgez
   p/jcJ2VdyhdO/zOsDyncZHp/idtJ3b1oAFaogr3OUV5uqS7pqVH5d4QyG
   G0YRpimgirjhYt1/IzYFVXxfxYf6KRAQhLXFx6bRVwYBt5LMvEs3x9WhB
   w==;
X-CSE-ConnectionGUID: 4ljgGTBKSL2ak/dWrvuP5A==
X-CSE-MsgGUID: v/WB2ra4RRGJm/UBWbmCZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="39537766"
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="39537766"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 21:44:22 -0700
X-CSE-ConnectionGUID: vhX11N2iSsqynX+fsN63vg==
X-CSE-MsgGUID: 9EaZtMePTcijimhaR5LNfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="102720799"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 21:44:19 -0700
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
In-Reply-To: <6712d07f3300b_10a03294bd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	(Dan Williams's message of "Fri, 18 Oct 2024 14:17:51 -0700")
References: <20241015065713.308671-1-ying.huang@intel.com>
	<20241015065713.308671-3-ying.huang@intel.com>
	<67118dcd2ba4a_3f14294fe@dwillia2-xfh.jf.intel.com.notmuch>
	<87bjzi6iig.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<6712d07f3300b_10a03294bd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Date: Mon, 21 Oct 2024 12:40:47 +0800
Message-ID: <8734kq6pbk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Dan Williams <dan.j.williams@intel.com> writes:

> Huang, Ying wrote:
>> Hi, Dan,
>> 
>> Dan Williams <dan.j.williams@intel.com> writes:
>> 
>> > Huang Ying wrote:
>> >> Previously, CXL type3 devices (memory expanders) use host only
>> >> coherence (HDM-H), while CXL type2 devices (accelerators) use dev
>> >> coherence (HDM-D).  So the name of the target device type of a cxl
>> >> decoder is CXL_DECODER_HOSTONLYMEM for type3 devices and
>> >> CXL_DECODER_DEVMEM for type2 devices.  However, this isn't true
>> >> anymore.  CXL type3 devices can use dev coherence + back
>> >> invalidation (HDM-DB) too.
>> >> 
>> >> To avoid confusion between the device type and coherence, the patch
>> >> renames CXL_DECODER_HOSTONLYMEM/DEVMEM to CXL_DECODER_EXPANDER/ACCEL.
>> >
>> > This does not look like an improvement to me. Type-3 devices that
>> > support back-invalidate are DEVMEM devices. The device plays a role in
>> > the coherence. 
>> >
>> > Your explanation is the reverse of this commit:
>> >
>> > 5aa39a9165cf cxl/port: Rename CXL_DECODER_{EXPANDER, ACCELERATOR} => {HOSTONLYMEM, DEVMEM}
>> >
>> > ...so I am confused what motivated this rename?
>> 
>> Sorry, I am confused about the target_type and coherence and forgot to
>> check the history.  In some places, current kernel still hints
>> target_type (CXL_DECODER_HOSTONLYMEM/DEVMEM) as expander/accelerator.
>> Should we change them to avoid confusion in the future?
>> 
>> $ grep expander -r drivers/cxl/
>> drivers/cxl/cxl.h:346: * @target_type: accelerator vs expander (type2 vs type3) selector
>> drivers/cxl/core/region.c:2450: * @type: select whether this is an expander or accelerator (type-2 or type-3)
>> drivers/cxl/core/port.c:141:		return sysfs_emit(buf, "expander\n");
>> 
>> The last one is
>> 
>> static ssize_t target_type_show(struct device *dev,
>> 				struct device_attribute *attr, char *buf)
>> {
>> 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
>> 
>> 	switch (cxld->target_type) {
>> 	case CXL_DECODER_DEVMEM:
>> 		return sysfs_emit(buf, "accelerator\n");
>> 	case CXL_DECODER_HOSTONLYMEM:
>> 		return sysfs_emit(buf, "expander\n");
>> 	}
>> 	return -ENXIO;
>> }
>> static DEVICE_ATTR_RO(target_type);
>> 
>> for decoder device.  This is a testing ABI documented in,
>> 
>> Documentation/ABI/testing/sysfs-bus-cxl
>> 
>> Is it OK to change this?
>
> No, why does it need to change?

For example, if the target_type is CXL_DECODER_DEVMEM, while the device
is a memory expander with HDM-DB protocol.  The sysfs will show it as
"accelerator".  This may make users or developers confusing.  If we can
show "hostonlymem"/"devmem", that may be better.  But apparently, we
cannot change ABI.

> It is unfortunate, but ABI's are forever. The place to clarify that this
> decoder is participating in HDM-D[B] vs HDM-H protocol rather than being
> an "accelerator" or "expander" device would be in user tooling like
> cxl-cli. sysfs is just a transport, not a UI.

Although it's not perfect, this is a solution.  Another way to solve
this is to separate device coherence (HOSTONLY vs. DEV) and device type
(ACCELERATOR vs. EXPANDER).  In this way, if the "target_type" in sysfs
designates device type, it could show "expander" for memory expander
even if HDM-DB protocol is used.

Another possibility, can we just remove this sysfs file?

--
Best Regards,
Huang, Ying
