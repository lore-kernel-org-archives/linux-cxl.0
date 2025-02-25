Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5035118EFDE
	for <linux-cxl@vger.kernel.org>; Tue, 25 Feb 2025 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503332; cv=none; b=Hdn/p1sYzV5x2T/cG82MoX5sCqMc0rxzUQsC21WEnlkvsn9RnQAp0YioVKsa2sYeV1kw/jiAt0lIsqOOUJrLpaw+2QywqCH7fNd5Yadbl8iKgzeIAj9Y4zw6u+vdCDd4ADFFENvHKukijSM9BLnFUIEncIIPdbLLA2xNM1FsJe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503332; c=relaxed/simple;
	bh=9xlFn5g8cxdQ//1YV8GL4NIfo1osiDVPo1VauVhhh/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eoVPZbSCLPQb+DKhe2fGILZYA0MifmCK0ncbvnH93esfmWUj81V8J+cjU+UV6EzxBqz8NRq0Bzdyf9esw5jod/hCPi97cQqhYQXZXmzvGaeBaILHAZt18EimqTHmseEMKWMJGGVNmaI2JSzo2v58m/wcpqNMqgqxPhpQ3QEr6gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jFUWR0CK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jFUWR0CK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740503330; x=1772039330;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=9xlFn5g8cxdQ//1YV8GL4NIfo1osiDVPo1VauVhhh/U=;
  b=jFUWR0CK6jz263orlnL0/PQmE0E5knsFi6yYy/q29WutC16t+Gej8d96
   eX/oT9fSglgmiByW8FRu/Qt4VBHjUDhCiHiJOs4htUEVkL3RZ6PTSSiWo
   njs660eWDjY/d/ORavKKkqKgxaVNW7VLqUrIHczTG1s54e5Ddg0vHQRDO
   1YZZ8LCBwUpevQdzZhAx5VMZe5G1F7y+GV3lNftG6f4QR4gZRKL4Q8KE/
   e0ml4uspeZCumeRelQqbb0rJH7JlDy5XGKDnMVbkxDQrwZ/GkQtfhpYA4
   p86tZcECVLnBF+9KA+XZkz/8Fkm6gSXXgBXx3fN14cv24BQNwKeIp6egM
   g==;
X-CSE-ConnectionGUID: lOnUp3z9SxWQE4ijIGRvwA==
X-CSE-MsgGUID: DHmmz0ogSzeIVXfaa8Iujw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="40505035"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="40505035"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 09:08:49 -0800
X-CSE-ConnectionGUID: 5kwN5I7eQbSL1hlGRXg0/g==
X-CSE-MsgGUID: ze4dpVkpRhWPJlVLUYsdxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="147268451"
Received: from unknown (HELO [10.54.75.22]) ([10.54.75.22])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 09:08:50 -0800
Message-ID: <9b1492d7-ffa8-4d61-a101-4fa9c2d71ae3@linux.intel.com>
Date: Tue, 25 Feb 2025 09:08:39 -0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ndctl cxl test suite fails in arm64 QEMU
To: Itaru Kitayama <itaru.kitayama@linux.dev>, linux-cxl@vger.kernel.org
References: <43568B03-6832-4EB1-BF46-EF0F176509E2@linux.dev>
Content-Language: en-US
From: Marc Herbert <Marc.Herbert@linux.intel.com>
In-Reply-To: <43568B03-6832-4EB1-BF46-EF0F176509E2@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-02-24 20:09, Itaru Kitayama wrote:
> 
> Has anyone noticed the ndctl cxl test suite failures I reported below on arm64, QEMU emulation?
> 
> https://github.com/pmem/ndctl/issues/278
> 
> I’m using Jonathan’s latest CXL capable QEMU [1], and the latest CXL kernel [2].
> 


Hi,

Sorry I wanted to spend more time and share a more detailed answer and
of course I got side-tracked.

Do you have CONFIG_RANDOMIZE_MEMORY on?

If yes then please try this either this:

  cd kernel
  ./scripts/config -d CONFIG_RANDOMIZE_MEMORY

... or this:

--- a/run_qemu.sh
+++ b/run_qemu.sh
@@ -681,6 +681,7 @@ build_kernel_cmdline()
 		"initcall_debug"
 		"log_buf_len=20M"
 		"memory_hotplug.memmap_on_memory=force"
+		"nokaslr"
 	)
 	if [[ $_arg_gdb == "on" ]]; then
 		kcmd+=( 
