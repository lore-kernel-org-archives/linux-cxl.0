Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA1EBE49
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 05:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747718823; cv=none; b=kTynU1dIzvBoZhKpGmsMsBqblyIqkWLI+OeWpUlCpmvVL+4gBtiZ9OJK1Oyhbmkccva7g8f4xBbuQBRJL+e2O5KMYoKdkfSSrFrRgmxhJjobh7fOsnKiGDqOyaIOLPYiLtqdMFSP/j1FEHIFQcueN1Qj+VoNpWVWZGgs8SHY824=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747718823; c=relaxed/simple;
	bh=n3T5luudZSpMVl6Ia98fiTVPKujK4FT/0XWQeKSabiI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nbDKeXDKC5CIi+ggsFVb6NTDUolCOFLvaemRb2ekeosATvS41yZigYpQv1ltr5QaSb0mceA5p+5qqfo46ayC9y/kjac6Gm8VBKENLthHgqiSlgFo+n2lksTF/Ac+WL4sv7M7Lqt2ZmhyQEi1GXNaSvc8819c1vCAeXgLNlVMIXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ue1GGPjJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ue1GGPjJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747718822; x=1779254822;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=n3T5luudZSpMVl6Ia98fiTVPKujK4FT/0XWQeKSabiI=;
  b=Ue1GGPjJTwiv9/OMlwypStND6pr5xfjwqGR+eELMLagKXrK6EOAS0f8S
   j5pf8U3uWwbTkkcWtZDMU2UT1ismvFfBy2WKV4giY0F0j9oqpvJJ8OLc4
   j3er/hGrVBdig+gP7LTODxY0rvaSl2uU2bWshoYWRVaXsmX1v0TZ95hkb
   b9cFj2kKt54erlGnlGSQYS8bvPv1bhAT/cRfcwtR+eCufMIx75MN/SDpb
   yAafBUO2c96OPTC8WIIbtZUhk8gU3BHw92N6pAh3kdz7xBYQ4JbO2+EA3
   IeuyZTHYu5+34O0MkVPi2wytZwQdqeI575KoT87ydStRRBJVEAjxdMKLi
   w==;
X-CSE-ConnectionGUID: rrD5Ff4eS6iU9cNStSCA7Q==
X-CSE-MsgGUID: M3M4ptnWQziCtM28aihrNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49700927"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49700927"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 22:27:01 -0700
X-CSE-ConnectionGUID: /OZwSIAoRECt/M8hQ0cywA==
X-CSE-MsgGUID: BId/FvVAQGmVdezCFJ7KSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140090954"
Received: from agrisant-mobl2.amr.corp.intel.com (HELO [10.125.1.252]) ([10.125.1.252])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 22:27:00 -0700
Message-ID: <f5ed30fa-e19a-43a0-9067-2562080ddbab@linux.intel.com>
Date: Mon, 19 May 2025 22:26:53 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marc Herbert <Marc.Herbert@linux.intel.com>
Subject: Re: [PATCH] test/cxl-xor-region.sh: remove redundant waitting
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: vishal.l.verma@intel.com, sunfishho12@gmail.com, linux-cxl@vger.kernel.org
References: <20250514112003.2150272-1-ruansy.fnst@fujitsu.com>
 <6827d6e591443_4ba8f100f1@dwillia2-mobl4.notmuch>
 <3f7bd5b0-4c1b-4a55-bc9b-2b6e75ab9a39@linux.intel.com>
 <682bba2f9ce2b_1626e100dd@dwillia2-xfh.jf.intel.com.notmuch>
 <d9b62e78-52df-4283-9004-18c0bc01f73a@linux.intel.com>
 <859d8415-5822-4f14-a911-1f1e48e344fe@fujitsu.com>
Content-Language: en-GB
In-Reply-To: <859d8415-5822-4f14-a911-1f1e48e344fe@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-05-19 20:38, Shiyang Ruan wrote:
> 
> Yes, I have tried to use `systemd-run my-original-script.sh` to
> achieve my goal.  It creates a new process which is outside of udev
> queue so it won't cause the deadlock.

Thanks for confirming! Also, I didn't know about systemd-run, it looks
very useful. Thanks for sharing. run_qemu.sh should probably use it; it
would simplify things.

Learning about systemd is a lifelong process...

> BTW, after you talked with Dan, do you think it is still necessary to
> add the `--no-wait` parameter to avoid waiting for the udev queue
> empty in some specific scenarios?

Dan's recommendation to have two different "modes" still makes sense to
me.

> Do you have any plans to implement this feature?

I'm not aware of anyone who volunteered to do this yet. I bet
there will be reviewers if someone does. 
