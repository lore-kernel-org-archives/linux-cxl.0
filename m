Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357EF41B8E0
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065504; cv=none; b=gvEglo5xr3yedJ7vNrYTk7ONeOzvCjt5XoUnmd8K6NNYYAL3FUGPowK8ezv2UklJcz8vkQnL9EtYfjcywSVJakNjsY8iqu9TJK/vSa/iFB3iB3iMezHMbvuJtVM4l2wWM7mCOrfJhHMnBJZBK7eCSqtkDUgyTCeTgD/xdN3QWeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065504; c=relaxed/simple;
	bh=jcCY0fCSpx3QirVvRU/RoqQbTsFduVL9H17E2G53sIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRh38lOmUwnAW2soW0CW2QIbEf5M18j8CjxMon5CdcUrxx7WBOpQuLepwgajOmKztLOZtDTt/GqcjpmNZaPBdU6zsQgCqqknWyngUuvq+uUGWaSlUgPp02xTGQ19LFjOMOrO/GHOijSdXVzExmO7G5nK+4BFQPuWzTCP/QvaHYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=asEbdaIw; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="asEbdaIw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790065498; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jcCY0fCSpx3QirVvRU/RoqQbTsFduVL9H17E2G53sIA=;
	b=asEbdaIweAk8XHfDsXx+WpjfLv88R+pFjTCAYTP5WEPW5SLwzgVCeHeQBEfY6DyB5Kh7EptVT59AaXjBG/F9k2PAR4FxomVUl1rHHZGAlsVzgjo5G6X0gVP9WBQgXHNC/fQTBEkuOtL27na29y2lWrrg3b4xKFdZe61GyLrni2w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XBT75sK_1790065496;
Received: from 30.178.81.152(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBT75sK_1790065496 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Sep 2026 16:24:57 +0800
Message-ID: <04792a46-9a85-4f2d-a1ec-4cf27a771e6b@linux.alibaba.com>
Date: Tue, 22 Sep 2026 16:24:56 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/events: Fix event type check for CME counter
 expiration
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
References: <20260921120932.1769566-1-kanie@linux.alibaba.com>
 <arFpVVElCIlCqvVb@aschofie-mobl2.lan>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <arFpVVElCIlCqvVb@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/22 01:28, Alison Schofield 写道:
> On Mon, Sep 21, 2026 at 08:09:32PM +0800, Guixin Liu wrote:
>
>
> Hi Guixin,
>
> Agree w DaveJ's commit log suggestion.
>
> Also, the Subject can be specific, like:
> cxl/events: Test CME counter expiry with equality, not bitwise AND
>
> You may want to add something like I've appended below to your agent instructions.
> It is intended to better calibrate your agent. Also try giving your agent this
> patch (v1 and v2) as a concrete example in the skill. It's a good one because the
> original one isn't bad, it is actually thorough and technically valid, but it is
> trying to make the commit log serve as the entire bug report, reproduction recipe
> and test report. That's exactly the tendency you want this agent to stop doing.
>
> Teach your agent (w example):
>
> For Linux kernel commit messages, be concise and focus on why the change is
> needed, not a detailed narration of the investigation.
>
> Structure the commit message as:
>
> 1. Background only when needed to understand the problem.
> 2. Problem: what the current code gets wrong.
> 3. Impact: the meaningful consequence, especially user-visible impact.
> 4. Resolution: what the patch changes and why that addresses the problem.
> 5. Brief "Found by" / "Tested by" information when useful.
>
> Do not include every example, reproduction step, intermediate observation, or
> possible consequence just because that information is available. Keep only
> details needed to establish the problem and impact.
>
> For small, obvious fixes, aim for roughly 1-3 short paragraphs plus concise
> testing information. Explain the semantic error. Do not narrate the code diff.
>
> Subjects should describe the change specifically. Avoid generic "Fix ..."
> subjects when a more descriptive imperative subject is available.
Thank you for your patient explanation, I summarized these to a skill, thanks.

Best Regards,
Guixin Liu
> -- Alison

