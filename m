Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC98224F6;
	Thu,  2 Oct 2025 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419159; cv=none; b=KGoIhTw1jid374HyrbjVssO5+UF55MXxwhANjwxm7Y+ksVju519pEEGBEx3oLDUE8+pdxcRvLCKkDc0Ue/wmVvpb0yAua7pVvqB9zsDxbwMbRNKLUrKdCw0nGqPBEENgrSn9VcgXMdYdK3xhTqF2gpRmKxxU+Ce1LMGMPPTR7AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419159; c=relaxed/simple;
	bh=ueS20b4msau8dN/Lx+uR3FJ78w85cKYSThuZTxlfpDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QoM4rHezPNDX6QDzDuCMZCUY3AyhqGFRXUmnkdeTTvvMdFXvsqLf2nwJgftyB4RR75bp3VtOZTJxB1ED9ySjryOt/kFCjbM1uNNoQsppgputHYE3GuYvcCCsTqg0GHvgIruoEA8zLKVoKIskTjGI5VK2c6ll2CXwqRdfYodCxvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/4bSUqN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/4bSUqN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759419158; x=1790955158;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ueS20b4msau8dN/Lx+uR3FJ78w85cKYSThuZTxlfpDY=;
  b=a/4bSUqNhlvQj0wp69TVcTB1/fKVnZDal+ueDtyI/DTtc1dh739T2EQn
   cJ/1Ot/vZAnUtjxXpKBf5TO9nIjZTs6DcytnaM/U4TVfnfKk07cgpOBxD
   c6efkuFVm6w/60trbGq35LC6nwDUb6rlS2Q865NoCJuhkkBRLbLbxlcu3
   /01htn5YyKI6zahflmD13vxx5Z54dFFWhYHnRT8/uuhGLtYAGQeRJJmna
   rvOXpTjaCvAAxg673LKFYS00B4B8ghsdxhpDLh5hB3HGuv6NSmoijANH5
   u6uZTD6G+XEYooDDoKtCP5lryQrvAa/93D3GCU2pZTjpNFiERIcwbTeaI
   g==;
X-CSE-ConnectionGUID: ZBQ1Jx1wQ5SKDDyVLd+puw==
X-CSE-MsgGUID: XrtcLeNxSC6XEk8mLPEzyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65528297"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65528297"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 08:32:37 -0700
X-CSE-ConnectionGUID: bp2OunliS9K412cnJD73/w==
X-CSE-MsgGUID: +doSR5cnRlCsw6iir01jmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="178346122"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.5]) ([10.125.110.5])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 08:32:36 -0700
Message-ID: <02a4b5f1-ad29-4825-9040-ff96e328f674@intel.com>
Date: Thu, 2 Oct 2025 08:32:35 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
To: Gregory Price <gourry@gourry.net>, Vishal Aslot <vaslot@nvidia.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Zijun Hu <zijun.hu@oss.qualcomm.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <aN4SSEmaCaxbeiwJ@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aN4SSEmaCaxbeiwJ@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/1/25 10:48 PM, Gregory Price wrote:
> On Wed, Oct 01, 2025 at 08:37:26PM +0000, Vishal Aslot wrote:
>> @@ -1210,6 +1210,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>>                 rc = init_hdm_decoder(port, cxld, target_map, hdm, i,
>>                                       &dpa_base, info);
>>                 if (rc) {
>> +                       if (rc == -ENOSPC) {
>> +                               put_device(&cxld->dev);
>> +                               rc = 0;
>> +                               continue;
>> +                       }
> 
> How do you suggest actually testing this? I briefly poked at this in
> QEMU trying to commit decoders, but i found myself incapable of
> exercising this path.

It may be worthwhile adding a cxl_test test case for this.

> 
>>                         dev_warn(&port->dev,
>>                                  "Failed to initialize decoder%d.%d\n",
>>                                  port->id, i);
>> --
>> 2.34.1

