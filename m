Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A173A5E67;
	Mon,  6 Jul 2026 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361820; cv=none; b=OkLoZZqtnSGgxlPRhVS1l61UTZ4Afx+JSavSG3iIPZd9XakuCHQnBYNdDi5QgjYV1frnezvzX1XGdLWiw7A8TXLFuxk+JM+Obg/5k0wTrhAstsPZASZELP1njmmK4adYK19GZziQjqf6V71m/30PhCzai4bcoLWKA7S1u4KgXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361820; c=relaxed/simple;
	bh=YiUiU1VPtH32GgmdgZJotEE8lE/kQplZPiWCOQrP10A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jNthN72X1YeWoxa1f1BWldEmgUgWhlbUpsJr9kZiHaNca0ZeTQAY4J0KMMpjmYrSgyM+22VVBzrncx5aNu2BjQ/U4VqDE/+lmmGfpkWsnA3b3dcEM6wRYyrN3lnnHViW7qD8lBAq19Q7RLOhFS2ZrXHVM+DJGPrcEeMTjubjIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oItDfwxu; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oItDfwxu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783361819; x=1814897819;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YiUiU1VPtH32GgmdgZJotEE8lE/kQplZPiWCOQrP10A=;
  b=oItDfwxu0faroNP6Re0kJ+pJqbeZYc/IrLJWa+PMoVCZaa7IYMkD5jZq
   D2c4omHrshQtOdEIwqUeTS/dZOyYpbMbwdGjw0+LmWiZ90aAV/FlPtYLo
   ipdSeUiKBVmpdeB+sHrQ20zUC8YVKPSVuxgrEG3bLHyP6GXl3YyVhFtBV
   viOplkBMQdAPWCVpse9INArQtbysxgz/RleKqg7fevDDGTzN2wLrOdO6/
   0Vmk695tTdgOsmZRKz6/XxRFaLwt3mJbl7a0Yc/itmpudR00TjUSSqzyt
   jKuzCHGeN2AgCC/TwRfEFazaIlM3zNm2HOKnhA0qH/kMqZMImcgmZNqJM
   g==;
X-CSE-ConnectionGUID: WaXaH9S8RkSKEONHVnCi5A==
X-CSE-MsgGUID: 3tOJXhvcRyChJftuYAsn+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="94650589"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="94650589"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 11:16:59 -0700
X-CSE-ConnectionGUID: EVpcIxGSSkGX6Lt8t0FkhA==
X-CSE-MsgGUID: Vsi/Zjz2RbKAlMXfRL3/0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="250436553"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.202]) ([10.125.110.202])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 11:16:57 -0700
Message-ID: <b784c30c-dc58-46b0-bed8-773e2b0ea0b2@intel.com>
Date: Mon, 6 Jul 2026 11:16:56 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/features: bound fwctl command payload to the input
 buffer
To: Jason Gunthorpe <jgg@ziepe.ca>, Zhenhao Wan <whi4ed0g@gmail.com>,
 Dan Williams <djbw@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>
References: <20260620-cxl-fwctl-oob-v1-1-5758e34d784a@gmail.com>
 <20260706155414.GA118978@ziepe.ca>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260706155414.GA118978@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/6/26 8:54 AM, Jason Gunthorpe wrote:
> On Sat, Jun 20, 2026 at 12:33:15PM +0800, Zhenhao Wan wrote:
>> fwctl_cmd_rpc() copies cmd->in_len bytes into inbuf = kvzalloc(cmd->in_len)
>> and passes inbuf and in_len to ->fw_rpc(). The CXL callback cxlctl_fw_rpc()
>> ignores in_len and never checks the user-controlled op_size against it.
>>
>> cxlctl_set_feature() bounds op_size only from below
>> (op_size <= sizeof(feat_in->hdr)) and then reads op_size - sizeof(hdr)
>> bytes from feat_in->feat_data via cxl_set_feature(). With a small in_len
>> and a large op_size the first memcpy() already reads past the
>> kvzalloc(in_len) buffer; the out-of-bounds bytes are placed in the mailbox
>> payload and sent to the device, and a large enough op_size can walk into
>> unmapped memory and oops the kernel. The Get paths pin op_size to a fixed
>> size but likewise read the input struct without checking in_len.
>>
>> Reject, at the single dispatch point, any request whose fixed header plus
>> op_size does not fit in the copied-in buffer. The lower-bound test guards
>> the subtraction and ensures op_size was copied in before it is read.
>>
>> Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
>> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
>> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
>> ---
>>  drivers/cxl/core/features.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> CXL folks, you will pick this up?
> 
> I think it should be cc stable too

Thanks for the review Jason. I'll pick it up. I actually had the same fix in a branch locally but haven't got around to post yet. 

> 
> Jason

