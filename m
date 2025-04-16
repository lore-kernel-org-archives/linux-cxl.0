Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E091C3039
	for <linux-cxl@vger.kernel.org>; Wed, 16 Apr 2025 01:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765453; cv=none; b=PrF3qjVAoZT+E5UP/0n6lHU5O/7IvDzN1IiiZu+PxRUFZhU5by/8iF3zcDGWAdbh7qgORKJjs3YvNxRzY2uul24yeWZqi53Rj07KB3AYAccyHjjFTH7r6AVW6Ty2WIsr69FiRSxeR+7BdHVYCgbA50qepwVHsbJnTwlpyauVGA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765453; c=relaxed/simple;
	bh=tPIIDWCtvCMUi0dba5wS/vnKRpQYieJRvDzGuUpS2cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1yuAea4QevdJVNPnLjw3mTQiIWcljCf8VA8Am8JSFMQ/at/dr2PZm8O5Wu0A3+OZaD789jSY4b8xTzzfyFWYSMQryuqvY+ip9sHmWsE7MfndfTBPiEypfGyG6JLRWS20nKs62afdFbINd1P5x0OYJCfoyydxYnadKSNIxzZLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eAgaZS00; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eAgaZS00"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-86117e5adb3so207121539f.2
        for <linux-cxl@vger.kernel.org>; Tue, 15 Apr 2025 18:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744765451; x=1745370251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YOzygePW3310tVx7kEfO3x/NC5w6EQLjdhpFeXqXF04=;
        b=eAgaZS00Pv3pt+zm9nWLIo3Md/3MzJGcu7IEemdvbWpI7g/8GnXXX/9prjIrmZFNpp
         Yx4Htw3VJhzm7BtnAouIJxzAXGlZuFJIGChlAoN46/bEoFz0G1ccPFudxVd8oje4laAH
         z3B4qOUSqaxLNk0XssFvCcgGCvLwX2n0Or2XiASfBdJgF0WyJrYeXWMqL5qSw3OkgE0G
         ukMafe5GVGmEPlKGGQorH4xV7r0kR3cFxk6Mm6u7swaqflBIfofITIba8V6KsqrxDgAA
         6GOwl147a/5l+fIQF1AuyL13ayaZsPTxa0ZYQ9oi7yL6U4nkxoQGUaRJ7e2g1ZRM+iOH
         pU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744765451; x=1745370251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOzygePW3310tVx7kEfO3x/NC5w6EQLjdhpFeXqXF04=;
        b=MFphUAruvhlbqx34JCnp7wO1gIfFCrf3qz9EJWHuGgEsE67PjYdV3rJkHm0hoo7W86
         mNJ9ULQ6Zi6jdJcht9n4ikQY4uOz74OrJo1P9kshvuLgufimR0k+RnuQfzvgLsJOJeEm
         5vBtBJLIIE88R+aJQl3QuB+e0LG6/3CH3+5QSFr0yQ/wXMxmTMHmWJWtXoEQ7o0Kl88z
         HWlTHG2Tx9yF178RWyIFrV+Vjkfa1JVoCyev+PjHehQ/Ui8aLUL1tZ/8RdCpY2Pd0IXY
         ADPPP+irEEAyW/sg/iKc32x+V9C9Ur9dFR5Yh+ALrpLixto0wWt8PBsepLSSqnuIw9wy
         pWXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuWQw0BMYgLXi4qkZU2K/9Zv+3jJxEF6+3v2QzJ/Yay1AXku8OdZFAa2/Sa6PouwEzWBx+63fr6hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIOl4FFgcvdGBkAAvRGGcab8cU9XEgrH6zJ8vIIRTdZuRVc1WY
	kQWrR5QSq6Hu2+SM+OLhRYM3nA+8tHg6wdEYFo3QJptqwWcPeJuotbsKf+ebJvYy3UEMUl926ru
	J
X-Gm-Gg: ASbGnctS52gbvb/MzcSrPejGpS/5GnCLkDNZwt8YGcH6oxX1HEBhJPDLv6Y2R00Qc/V
	1iGwU8TeZk48k1vXWVSeAIPlRWSWhNpmlXOLxfr3sIKBbE6xBHFFRXfiD/4w3iN+v+eXksIkjz0
	zylp4SOVWhE9uvqGHwl0D09UXhkO3zDHHqm3D28l2Sf8PZDRailfk+JN9e5dJVbL+P/KBu6jbQN
	mdUT7tWE0truPXEzIXrywaUrogkYaJqy1qNlkCeqklHrhCPaR+fMSfFi501CajIbGjww8k8ZIoT
	/7HlbjsL2Wx6IYJnFFUwHn1p2NdHqvSIqWS+oQ==
X-Google-Smtp-Source: AGHT+IEHI5YXtsH3GtE+xAxjPnoEaxwITdOpITzfsT2ZontVDQfoJEe0M8gxlFjwjY706Hy1dO+lEg==
X-Received: by 2002:a05:6602:360f:b0:85e:8583:adc8 with SMTP id ca18e2360f4ac-861bfbbd3d6mr192307839f.3.1744765451183;
        Tue, 15 Apr 2025 18:04:11 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8616522cf6bsm275091139f.7.2025.04.15.18.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 18:04:10 -0700 (PDT)
Message-ID: <15e2151a-d788-48eb-8588-1d9a930c64dd@kernel.dk>
Date: Tue, 15 Apr 2025 19:04:09 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/11] pcache: Persistent Memory Cache for Block
 Devices
To: Dan Williams <dan.j.williams@intel.com>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, hch@lst.de,
 gregory.price@memverge.com, John@groves.net, Jonathan.Cameron@huawei.com,
 bbhushan2@marvell.com, chaitanyak@nvidia.com, rdunlap@infradead.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-bcache@vger.kernel.org,
 nvdimm@lists.linux.dev
References: <20250414014505.20477-1-dongsheng.yang@linux.dev>
 <67fe9ea2850bc_71fe294d8@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <67fe9ea2850bc_71fe294d8@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 12:00 PM, Dan Williams wrote:
> Thanks for making the comparison chart. The immediate question this
> raises is why not add "multi-tree per backend", "log structured
> writeback", "readcache", and "CRC" support to dm-writecache?
> device-mapper is everywhere, has a long track record, and enhancing it
> immediately engages a community of folks in this space.

Strongly agree.

-- 
Jens Axboe
