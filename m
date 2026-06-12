Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CD9392C5F
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781295544; cv=none; b=rxwNUB+TK285tpQbMhwFYV9Ia+DlyaM67apL1D8UYXMyYgDjuaIGr/1l7+kfV2g7UulQJ57cI5fQW4RemXkHcOysupJv59OL12A+EXyqthkNlWCHRa6OtQAXGgQirfVYceB3kNPu6g4YdbSy7ymmJfGKCMw9jTWcTsZQ3QLLF6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781295544; c=relaxed/simple;
	bh=LWL0z6xDiuFPIzPmumSKJP0SOSglQ0UycF/yEZ2qTDw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Awi7dvxIr+q3K5Hpeq9Qz/tpPj8qnhYXOqCD2rVTAurGulHYuZXN5vziyFNGFJ8gleerxNfVcSj1DbRMgdg47wO2k3l4OL6uRxrzw1eJJbWnHuyoAhWpEgjU62G9E0iSr3U4lMyEEq3wCFzr625quwytwm6pA9QQzv9/6MQmDPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcBMIrkh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcBMIrkh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73B21F000E9;
	Fri, 12 Jun 2026 20:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781295542;
	bh=/VSKXzQl+Gx+JknyAWhZP4dN+pwTQTuWw+7fbCe5Rcg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=BcBMIrkhxaXxPyw3gjK0Zujho4hbyBBuujPoVVY09Vj+xsDdlyRFKnh+AYZhYKils
	 /YFbxZit/vo5S26bkMOq0FI6dXGpexrxXYuk8iRFZWmQ/e4pzQnHPhLrXkHr8Z+JqL
	 yI+Fw0PHfS4FxDsFw1V9YQQa/5BCKGQd8Ny1qlaphkkJNAeyMDtLnn/WH6bZGfomuY
	 rqLsdnQwwB9lWNo72j7Lso7uDkmF9eUAm0hK3eyHySSuUKFqbVe+G/21S8LegXCsaO
	 kNwqvYHj5l/PqXeXbJiAydQfe/0oM0HnwW42kt+Fkr1gAkTpBzTumZ4kNJ82VKKkpq
	 LieD5kpRRYRYw==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 03926F4007A;
	Fri, 12 Jun 2026 16:19:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 12 Jun 2026 16:19:01 -0400
X-ME-Sender: <xms:tGksaje5kWpj5hITzk6XCWocIZ0FGMJcMg93yhJV798Ej0cMsc1JgQ>
    <xme:tGksagMHViCtyVDpEf4lEZFIjpoREUyfAwggcZoSgHEgVt63iORhOw3aU70l7Qhok
    D55jXFO1djRgg7wHX6cBLYDSmGrYhZSduCjnVwMPhTs661kirsFcIjZ>
X-ME-Received: <xmr:tGksahi8m41Xhs1J2NMFvJpIbvDsz0s5zbGRGWZ9wUE4mfTSmEUnnBHiXHh1Em-0-X9udnEkdimF77MD5XJd3l1lDyr64ecuSko>
X-ME-Proxy-Cause: dmFkZTECi8DNOonHn7sN9gHdj8ax1Kx+RTO2kXhTzl8gBQr7vKCxNFchqzEfU8vhMdrHiL
    IOpd8o9kmzPoMhk7u7A1yITYGS1Se/W/6PddvgqmCgmY0Lhy3SzFiQXDEF81abdB1HWTUk
    a+3Rz50+dZQh5W2Hj3vQkErlc8IrFkdaRyKXYeORF9ZPaVHHHYqOGRaDKZSNh4mlu/ZDUD
    SsLrID42pCPBMNFX+HgLkQI62aQSw6wmPvQJv3uxzZZz++EOrV/AwikIqVWMZ7TfDP2ZTp
    eeviQElPpA+Rx6Sofs5ArlyfVFAuLuQIF0g8hyYMuMSLWE0scUdpHRy/+P9VtIf8vV1kNG
    AvsAN8zXdW+Hph9UE8qs7M7zliJve8fmwy8vCoT/Xv1ujOmoKkJPjr6XtdDhI+rvX2Nu0h
    LgbD/jtUpi7bCTtaMr/hKJ4nklxLmy+Pa3MkbJ5VxaXqkCsCKp6B9RRExMGxfQUhUw8GUg
    zyovVkLNZVPWMgvB8UFtny5kj9RelLaKWw7QqZEMdixcZTqxt04RXRPxbsxFlbD4BO3l4R
    nqorCf/0YZs+09h55vJEWf6wKIRoVukn/5ShNgTEaZcigwfzCRrsMJRI/CBes8QiaVc/SA
    O1x7cjiPr+Uu9FGo5kv9sPcLolADB0VrrUoVqFWYaOCHy8LrF/nuy928PltQ
X-ME-Proxy: <xmx:tGksaj20jEViS1RklRHJmzp6oUcztVlKZDNTzy-FTrytRdGeTFyJEA>
    <xmx:tGksarjBVMJAlnCy7Xk7qC22zYizTeqYo34aFQjp_pSjbFGfgynyCQ>
    <xmx:tGksajcZWFgAf89jcWfvjXPRfQTryj8GRh6FZ__qYgjcALvfidLAyg>
    <xmx:tGksauk5yTwCFVdqWcdiuBkxs5npaKeYCtXS1itO2SAybsu5_ghvYQ>
    <xmx:tGksasvkrTeNCsNZ3DW6Kg96KdDj61yiG6HcxuRZv6vEarbHOBmCvxiU>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 16:19:00 -0400 (EDT)
Date: Fri, 12 Jun 2026 13:18:59 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, 
 linux-cxl@vger.kernel.org
Cc: djbw@kernel.org, 
 kernel test robot <lkp@intel.com>
Message-ID: <6a2c69b3480a5_9b855100be@djbw-dev.notmuch>
In-Reply-To: <20260610001324.260268-1-dave.jiang@intel.com>
References: <20260610001324.260268-1-dave.jiang@intel.com>
Subject: Re: [PATCH] cxl: Add dummy function for cxl_memdev_attach_region for
 !CONFIG_CXL_REGION
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Dave Jiang wrote:
> Add a dummy function that returns -EOPNOTSUPP for cxl_memdev_attach_region
> when CONFIG_CXL_REGION is not enabled. This allow sbuilding when
> cxl/core/region.o isn't built.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 9b1e70e8f9ec ("cxl/region: Introduce devm_cxl_probe_mem()")
> https://lore.kernel.org/oe-kbuild-all/202606100401.GOjzpKHo-lkp@intel.com/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> 
> Fix is against last patch of Dan's [1] series for Introduce
> devm_cxl_probe_mem() and fix region deletion.
> 
> [1]: https://lore.kernel.org/linux-cxl/48834616-6e75-4936-89be-9224a6dedefa@intel.com/T/#t

Looks good:

Reviewed-by: Dan Williams <djbw@kernel.org>
