Received: from slateblue.cherry.relay.mailchannels.net (slateblue.cherry.relay.mailchannels.net [23.83.223.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E0E3C3C0E
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761599; cv=none; b=hLyQjYQMoSrY3EvH32sxBFcMICngMgVxob/CrMwdMnT3YUULUjXfesfKRy0f2m/DuJ8hY5C8RxOf4FbaEcFEeMcL5tDwpXCzrqxGUjeuRvqzQ2sIK3TiauRNKkng9jD5PiGaEUPe8u19m5mALgmi82zhEZkweSxP4G9Dfas321Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761599; c=relaxed/simple;
	bh=FVvLauXVtqR1ENLAID5FtDyvVHI50umiDLydo3uhkNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4L6S/fL2gsrYZTGh5L8v00TUFsEAzH7VLey9x/8b+NV6CYIF9F6m60lUno2jORRZvnJlxXf7KeJlgnZN1n+8Vn0tTrbceXpGxx9YzuYn1wN+y+T1msrb7ziaxTXnd8BxbkPo0OBV8S9KQ+R4/dCGAIR54KwkTTghJgtDzzTPAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=XkPK9D4c; arc=none smtp.client-ip=23.83.223.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="XkPK9D4c"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C3757381553;
	Fri, 18 Sep 2026 19:59:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a239.dreamhost.com (100-99-131-46.trex-nlb.outbound.svc.cluster.local [100.99.131.46])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6BD1D381504;
	Fri, 18 Sep 2026 19:59:52 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Towering-Trade: 623dab064ce2a9b9_1789761592682_2201549839
X-MC-Loop-Signature: 1789761592681:1850497492
X-MC-Ingress-Time: 1789761592681
Received: from pdx1-sub0-mail-a239.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.131.46 (trex/8.0.2);
	Fri, 18 Sep 2026 19:59:52 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a239.dreamhost.com (Postfix) with ESMTPSA id 4hmk475kyfzyrJ;
	Fri, 18 Sep 2026 12:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1789761592;
	bh=Q02Amb1X/pU7TQmuNMDaaDpeOOZO6KtDkbvOGvK1bw0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=XkPK9D4cb985fPZ3ppRwBgH0mMAl4aTjbd27QM7IQkKp2OyrHpwGmZSY1jcbO0NCQ
	 ZsAC/WkhxD8qhAc3Ble45F9T2hr+K6cNBYF2mPyy7YAYrHkOqChIB+V5FB4NjB0SxK
	 9R/D112ON21CmfCho4NFKejbWydDtKdRs7ECWZl4KaEgzirozSvb1JnomeAnAuEKts
	 I7lIQ/ZayadeJ1gIbBx+JbGYSuy4dKW3gmKMHzrGcXoZE+X9jv6p42KitFlGzt8EdU
	 tmJPjlEcuuG/Jaz/NHGA++qy4+M+QwFJca08fFwt31B3VLkVMZacVdzbJJ1v+F/+d7
	 qWQ2DegF3mn4g==
Date: Fri, 18 Sep 2026 12:59:48 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave.jiang@intel.com, jic23@kernel.org, icheng@nvidia.com,
	ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v8 0/10] cxl: Support Back-Invalidate
Message-ID: <20260918195948.466k7yjy7xaotjkb@offworld>
References: <20260909170302.1550680-1-dave@stgolabs.net>
 <aq1pK9oYEjoXpicU@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aq1pK9oYEjoXpicU@aschofie-mobl2.lan>
User-Agent: NeoMutt/20220429

On Fri, 18 Sep 2026, Alison Schofield wrote:

>On Wed, Sep 09, 2026 at 10:02:52AM -0700, Davidlohr Bueso wrote:
>> Hello,
>>
>> Changes from v7 (https://lore.kernel.org/all/20260728144136.709882-1-dave@stgolabs.net/):
>
>snip
>
>>   - New patch 9: cxl_test mock BI topology, so the ndctl suite covers
>>     HDM-DB assembly and cxl_acpi rebind replay.
>
>Hi Davidlohr,
>This caught my attention, more below -

Hi Alison, thanks for having a look.

>
>
>>
>> Testing
>> -------
>>
>> Testing has been done on top of upstream qemu with the CFMW options series:
>>
>>   https://lore.kernel.org/all/20260720233242.901544-1-dave@stgolabs.net/
>>
>> The qemu-based test suite covers 34 topologies, including cascaded
>> switches, interleaves across switches, firmware-adopted paths, device
>> resets and AER recovery:
>>
>>   https://github.com/davidlohr/cxl-bi-tests
>>
>> This passes regression testing (nothing breaks) ndctl suite via cxl_test,
>> now with the mock HDM-DB window of patch 9:
>
>I'm seeing test output below and wondering if that is done the cxltest
>module config or qemu config.

So that phase A and B are all cxl_test module, the rest is qemu (cxl-bi-tests).

The actual ndctl tests are mostly regression testing that I didn't break
anything, but I didn't include the actual BI stuff, good catch.

>
>Is there an cxl unit test update or addition to specifically validate BI?
>

I have these patches queued to send to you once this stuff lands in the kernel:
https://github.com/davidlohr/ndctl/tree/cxl-back-invalidate-test

The first commit is the respective test script for patch 9, and the second
one updates libcxl for the new sysfs ABI introduced in this series.

Thanks,
Davidlohr
