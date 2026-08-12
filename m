Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6686361961
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522449; cv=none; b=joAFZmPDxAsBiaBLN5/JWN2wR/DohpxGztRJNvUxC8soUxC9h8ziw/6O+KPTV0+Bj9Tm/3vGUvkH0STQYYK8Rn5PDs+7nHfP1Zmw/7E8UXEp9tivFegQGJnpV/UywuYgQNoUwjmwBeqYVJz6Miu6ygNcp9DzEeSmMIajWaU0bd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522449; c=relaxed/simple;
	bh=Sa6UtcjvI7rpg7bBtaX4SvB6OexFxOWIL2ogjuHOj2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwxRzhn4q/Exr45CSmt4w2s3Sy5W0YFvMwYWSmirkbs9YAR455au4VxBqOlran1OVhyB4rm6gyhqc//O+BNrOxNymU8vfNsuX2jMhrwu0AlcIM/lNJqloCOPQLWdVo5eFtO9PjQZDMBgqsLmI8MsywIpdnx4HS4w93iaSBE0eNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=agGFt+UZ; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="agGFt+UZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786522437; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7OcBfEgHNHhuLZ8FXfr1zJ8FIwb+MYE+l9iIlEpc6a0=;
	b=agGFt+UZ92Liv1QfYv05KSHR/rWOJBBY7vxcOSt7ukXM+DeJnKT8ie/O8qktNdMieCgnWiY+5yIQIJQuKiTxtiRIu2jaTWyTWqAosHVnOsHUBqMCE8evpIQ549FO4iwC9qq+hzO9f6bucwzDMu3PK/PXaLl5WHlBzvm+tMbDiP8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X8r2nN5_1786522434;
Received: from 30.178.83.207(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8r2nN5_1786522434 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 16:13:56 +0800
Message-ID: <31d1e8f2-bd00-4b88-8637-f532350c283b@linux.alibaba.com>
Date: Wed, 12 Aug 2026 16:13:53 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/pci: Fix NULL pointer dereference in reset
 detection
To: Richard Cheng <icheng@nvidia.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org
References: <20260812061027.57037-1-kanie@linux.alibaba.com>
 <anwiQwy1bR-0peFJ@MWDK4CY14F>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <anwiQwy1bR-0peFJ@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/12 15:38, Richard Cheng 写道:
> Hi Guixin,
>
> I think we should cover the case for DVSEC-enulated decoder as well, where hdm is not NULL.
> That could happen when HDM registers exist but are globally disabled, so the driver uses DVSEC ranges instead.
>
> In that case it will still pass your "if (!hdm)" check and reset detection still reads the unused HDM COMMITTED bit.
>
> Maybe we should also check for "!cxld->commit" ?
>
> Best regards,
> Richard Cheng.
Yes, and just "!cxld->commit" is ok, this cover "!hdm". Best Regards, 
Guixin Liu
