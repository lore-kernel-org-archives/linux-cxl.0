Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940A02701CD;
	Thu, 24 Apr 2025 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509656; cv=none; b=A3/7UGbmjeUyer/84Pmbf0Z9NwOdZMxMufenwrAOWvmMwYh5jt0Ecg+ahFE0uvCPIw0Ds9oi7EFw9TILk1hZkIfSSFaTNGjFOhd75jmoxNntCtSguGeTuV1KcsRSWO0BshE3LnVb6U9AP5qhgVKxVOwjZeeI65BizcHGe+FUK1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509656; c=relaxed/simple;
	bh=74ZeLRpXZfizCoPEQzJTdJMtwnw1+9U/A+HDQpq+26g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwRsZT5KU2vGonRajAIakeKyT1bf3cnZMH0vLkG8RPKpkVDLLItNmdhMkoYsjrjbISoCIvM1Z/OkF/8TSDWORVgK+CofOaq00uxhBUoi+ZjLc5vdvC+ptkQ1l5mXM7ARvNK92iwJ1GnEDPJHzZ2J/zUQE+nt0lxyNgZSNpw6MYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKlHMFOs; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKlHMFOs"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224100e9a5cso15354655ad.2;
        Thu, 24 Apr 2025 08:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745509654; x=1746114454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=74ZeLRpXZfizCoPEQzJTdJMtwnw1+9U/A+HDQpq+26g=;
        b=bKlHMFOs/6Q0B5YwRG+dSm8BkaBpTlAKmYs2pB8jLZKh8X2cF5XOsUilZ3fApOAq5Q
         HuVVNOJrexZ5wL/92+IZ0gSwtNowJnOnUMWw0MXaKvJ+RVMCZh8epQqO/ZFRX1aFv/MV
         He5CGLm67/qTaXqClLRWNySzH6iOBLvIlCYaVfAargwevEQ+vrTduArYjhZtxCXvGjSO
         OHHVZ7D4n3FdAS5aAa2y/6qY56GIUfu1Ks9d7vg3XY4j64MAo1RIVr4A7rUttzqGKPE5
         wwHFUUCrwdsTJa1nsuhKwFxCtbBmFBln/DPvivoXrmX7LPf86KvAgICHuvom9tPBc+L/
         Vddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745509654; x=1746114454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74ZeLRpXZfizCoPEQzJTdJMtwnw1+9U/A+HDQpq+26g=;
        b=KeAf0BDjHkxfD6p5R9x0NyfDLTgiofkFfsSq9RZQLDcwrCbrxxcsFRw8AgJJHYW6q2
         g0IFR4TKVCFxsm5JqMaYFW+a601n2fsESbNJpb/sr7TxFfd4Cr9l9Bypj32hx1hURCF6
         YQSWMLWHxzUp73VU5tBqnhquxfG+yVf0eK3c2NjsxuXLWaNvZV34u2tdzjsnlGkUVPPR
         e3VPeD3/2/wkOf2jqlvIXsL6cnj1jwQTZhPck4JEkK7nM8gnGkus1amPjXS5BvWsbyBm
         P7HBW+xs3XgDSsX0ops7psX3tLeUg7Pf/bE/69a/J//emdITKQ0bABAnEZm6Zc6mT06Z
         1nSg==
X-Forwarded-Encrypted: i=1; AJvYcCUc0yISSCgYBI2fNZJpkEatMPcu1ctmzKX9ONN0x/uxCC2bijiURpdBux3UGATLZtK8VWgL1cDJnfJII6+a@vger.kernel.org, AJvYcCXGvjNmufCdCg+Ry54CW0SAQzSPmXZmrX4JDhGTlT8hMlfqF9Xh4upLR/tRbXMMgANIH9SgrruI/r8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd1gI2WskO5FqlJO0GZlqk0UyIn8ZJBnZi7oYLusOFtlabgtsP
	Lj1Ow1U2q+WLZ1mWlN6tDxEEWSyGq+rgFd3uAefGfx1NKCDEvTBs7nc9KDR7MnNjyQ==
X-Gm-Gg: ASbGncuoQmlxZOXq54d1vGBnF4Px0iWTZn/GIysQQG/bbR3K+SPRktXAkLYXzD1r7kp
	G577Twyg9unadryd3LXar3qAc7p9KrSe1wn5pgpi/NmqrKse6cwIBo0UZGkrryfy9IbPstxmLaz
	KjqWcqLBqAx1Zwg9605QYbTD+zRk+Gj0qtrLSFSqasl896WtwKefbOeAsd4HKpcCi8Skt6cH/z1
	Fhif+FqWggKtc28zu/UbpWxqHU3/nKE6MxjtMWIcLGzvvwTD+McCemrvlEkaWOs02Wf02BhWXQk
	wWUDu11ZMHQn4YHuxlCmOUiNb8OynhvqGyH83GtC8lXTJX3S
X-Google-Smtp-Source: AGHT+IFrqb6lN5+lsml1n8RT6jAybU7JqCpvKfKYKDxfbmkx6EypKo8ZO0kkxmWhNag4a5baPsqqjA==
X-Received: by 2002:a17:903:4052:b0:223:5c33:56a2 with SMTP id d9443c01a7336-22db3c1d84bmr44081245ad.28.1745509653441;
        Thu, 24 Apr 2025 08:47:33 -0700 (PDT)
Received: from [10.16.12.253] ([61.83.230.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7a40sm15045355ad.147.2025.04.24.08.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 08:47:33 -0700 (PDT)
Message-ID: <72d355b4-73f8-458d-99e8-8e4f02d5dd79@gmail.com>
Date: Thu, 24 Apr 2025 21:17:28 +0530
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH] cxl: trace: Fix macro safety in
 CXL_EVT_TP_fast_assign
To: Steven Rostedt <rostedt@goodmis.org>
Cc: dan.j.williams@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250421184520.154714-1-shaikhkamal2012@gmail.com>
 <20250421151239.7981f1fa@gandalf.local.home>
Content-Language: en-US
From: shaikh kamaluddin <shaikhkamal2012@gmail.com>
In-Reply-To: <20250421151239.7981f1fa@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/22/25 00:42, Steven Rostedt wrote:
> On Tue, 22 Apr 2025 00:15:17 +0530
> "shaikh.kamal" <shaikhkamal2012@gmail.com> wrote:
>
>> Fix checkpatch.pl detected error
> First, checkpatch.pl should never be used on existing code unless it's
> yours. As the name suggests, it's for checking patches. It's not to check
> what's already been accepted. Please do not submit patches against accepted
> code because of what checkpatch.pl reports.
Thanks for your suggestion.
>
> If you run it on code and it reports something that you find is a real bug,
> then sure, fix it. But don't submit patches on code you do not understand
> just because checkpatch.pl says there's an issue with it.
Okay got it.
>
>> The CXL_EVT_TP_fast_assign macro assigns multiple fields, but does not
>> wrap the body in a `do { ... } while (0)` block. This can lead to
>> unexpected behavior when used in conditional branches.
> Next, this is not a normal macro. It's a trace event macro and
> checkpatch.pl fails miserably on pretty much all tracing macros.
>
> Thanks for your comments.
>
>> Add checks to ensure cxlmd is valid before accessing its fields.
> If it is invalid, and we do what your patch suggests and just not write
> anything, the event it was writing into has already been created. If we
> exit out of this macro, then the event will simply contain garbage, but is
> already on its way to user space. That means the output to user space will
> be garbage. That's a bug. In other words, if cxlmd is NULL, it had better
> not be calling this macro in the fist place!
>
> -- Steve
> Thanks for your suggestions and comments.
