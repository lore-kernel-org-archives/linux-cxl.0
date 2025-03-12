Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300F07083C
	for <linux-cxl@vger.kernel.org>; Wed, 12 Mar 2025 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802756; cv=none; b=N4cXrbN4zq6zDXk8C8rP3CuDHUP1XErphM03p5MOQmARdoRoGG35qZ8usG2r2nti4XnJFgZlTUHktqONGt1YlEVzrYAjCbEDunKiFRN+aRAehPgUn0lZa4Byl0c/JpvLqWYDe62JMoKJvupyUuq6LZ6RqCkjWljOekIcXLDpCC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802756; c=relaxed/simple;
	bh=FzdCcwsmBnp/9cO/AcV+7P8yhjJP3N9NtZ7qFkiCTX4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWL5qBA4v75tjbfEbQzoTI5LrneY/LEP11PUJpn103yVXs5j3DUh48gY7EzFy3b1XZxvZCybjdSOBNvn470okTp1NPRruOloylaAAspQox5tFpqV+va9055EmWXwuSaQOdK5R0zRxPsBl/KJOBKO4a5lRMYUeVuqLf5UnbIDCFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZCdld42Pjz6J9mG;
	Thu, 13 Mar 2025 02:03:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 73CDB1400D3;
	Thu, 13 Mar 2025 02:05:45 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Mar
 2025 19:05:44 +0100
Date: Wed, 12 Mar 2025 18:05:43 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Junjie Fu <fujunjie1@qq.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<viacheslav.dubeyko@bytedance.com>, <zhitingz@cs.utexas.edu>, Gregory Price
	<gourry@gourry.net>, <svetly.todorov@memverge.com>
Subject: Re: CXL memory pooling emulation inqury
Message-ID: <20250312180543.00002132@huawei.com>
In-Reply-To: <tencent_E9F3F01E0D2303378E16505CE4CF208AA908@qq.com>
References: <20230215151854.00003e34@Huawei.com>
	<tencent_E9F3F01E0D2303378E16505CE4CF208AA908@qq.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 10 Mar 2025 16:02:45 +0800
Junjie Fu <fujunjie1@qq.com> wrote:

> > Note though that there is a long way to go before we can do what you
> > want.  The steps I'd expect to see along the way:
> >
> > 1) Emulate an Multi Headed Device.
> >    Initially connect two heads to different host bridges on a single QEMU
> >    machine.  That lets us test most of the code flows without needing
> >    to handle tests that involve multiple machines.
> >    Later, we could add a means to connect between two instances of QEMU.
> > 2) Add DCD support (we'll need the kernel side of that as well)
> > 3) Wire it all up.
> > 4) Do the same for a Switch with MLDs behind it so we can poke the fun
> >    corners.  
> 
> 
> Hi,Jonathan
> 
> Given your previous exploration, I would like to ask the following questions:
> 1.Does QEMU currently support simulating the above CXL memory pooling scenario?

Not in upstream yet but Gregory posted emulation support last year.
https://lore.kernel.org/qemu-devel/20241018161252.8896-1-gourry@gourry.net/
I'm carrying the patches on my staging tree.

https://gitlab.com/jic23/qemu/-/commits/cxl-2025-02-20?ref_type=heads

Longer term I remain a little unconvinced by whether this is the best approach
because I also want a single management path (so fake CCI etc) and that may
need to be exposed to one of the hosts for tests purposes.  In the current
approach commands are issued to each host directly to surface memory.

> 
> 2.If not fully supported yet, are there any available development branches 
> or patches that implement this functionality?
> 
> 3.Are there any guidelines or considerations for configuring and testing CXL memory pooling in QEMU?

There is some information in that patch series cover letter.

+CC Gregory and Svelty.
> 
> I sincerely appreciate your time and guidance on this topic!
> 
No problem.

Jonathan


