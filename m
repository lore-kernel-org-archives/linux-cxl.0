Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7370497B68
	for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408020; cv=none; b=nnv+G80Q8HMmgbpFUeSJYIcn0BRumDWLRx+QkQv2/J0Ijpv5zf5JK0PX77BACQKg7GMgoNe817o6tSWW4GiC5z84QSUjHlTHrZKv0hxDtT12iRVc6Sjfk08dfH7TSyTYrx/PpQzWvAPC+sJG06AXM3KkhJ7R0tDdn/feza2ZBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408020; c=relaxed/simple;
	bh=WSfODTiWoc3NsQ0K1W4/ZLgkIxuHZ+M/l+wBk4Q09Lk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6jMJd+50mnBmsmmMdM1ih8d4OVgCFE3xEYuHQbx0wt7B1mFdOkj0XSzLViIVWtJHMWaWP9RXJL85V+oFBKm0j4nPhzQUlAMwOk5I5scHfA5BfOHaTQMRjdPo4SLAjQtLdOuLRTWg+hQuj5ngsS+ZyPsEVyyGK/78UdfxZ0Krfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrmFBelF; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrmFBelF"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b350c6920so2104587a91.1
        for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 10:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789408018; x=1790012818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MKqIsTiqCr2Rj37ZsJNqBA0JRDoXX2ERq8ueatT/jmg=;
        b=nrmFBelF/o+KksQTEK2unFjyElaRq9TN57c7aKqXJxYPc4cevC3Rp8iqvGQaA2yP/7
         obrrTCYlB4f4jVKl7MQJrPBJu/ZjYRzFemHCAXzCJ8BQe9H+tiqwpcMlEkXqzU3jHOd1
         JIlQtXoUrOdhoYqUho+zlGUAP99cUOaGlrUKRAQdpGJGaJQdVjU33mlA6r9R+tZcP9tB
         Ld7Ggk0MSmI95yY4EM1GwkVTFf1eRl75GKrFMdpSJtiyblhRFhg79QG3DYn5xJUKX3vX
         1wmMS/hL4oSZJqlXoRlhv2ijXPIiLv7RrtA0xIoBA0IWqcZIhCiTG6Shh+MB+IfyQOaj
         Cs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789408018; x=1790012818;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MKqIsTiqCr2Rj37ZsJNqBA0JRDoXX2ERq8ueatT/jmg=;
        b=R0Fs7GcKMYmRaC53S4x4rLo0hBKaLkxZYbVTFSfz8GbKK3XLtEoKgZgeo7lwBksDG6
         16qF6a54vS1Q74Ag4FaUgq309LIw3x0M4yw3BC7H6qok8tujlfEIH4J2lHGl3yRlfOzd
         mawhaMAuLRI4LNU7TKAUuV7xwIHaA2Og1yOy69T+XYtYmoCwRT/23IPZ2IdO+0K5kUA8
         qpOO2IBisc83aHw6CpRiXWc/F5lDqaLa64qN+zovYoZvdvnxRK6fXI4SvAQbintf5aJA
         JZNpJnJpVz6BU7I4y6EO6+s6Bge89AHwnlWcLzEBd4I+/SE7G5iqkvJcl1tjCP9sP/Z7
         JQAA==
X-Forwarded-Encrypted: i=1; AKwUvBwwf1B7Wcpc3g8WDl36MO4cJFW//xli38lcTBp5DLZ6i1PkTtv+f5Z43JQQ5icSSfDs8Ioawn3i98w=@vger.kernel.org
X-Gm-Message-State: AFuF++knbul+qQMkJrZ2qr3UDp6uxKMq/d9aF/ocXqJn19JEa8av6+Qu
	dSUsoeeJLQ46Ol7cinZdYAMY4jjzwZv33zVvuoep08jqXJUCIbioQ0S5
X-Gm-Gg: AYBFou36d0lGzgR59RP2eKyRf1MvFydDQf3Oky2DNss0p5n1qhuv6CP/oUibhf2e6MR
	+9yQCTTj8RTEucM/zMZ1bvt7vBLQENkCJ6SQpmCh9zpGlk3j21kSlmR5bYJHp655xWX3cJLSkNu
	ji/mgC2HAULZsdLnzStTK5cL/swWV9O2wKBBFnKKABoU4S4zH84A9Mk0Epazn+mTgSO0nCx0cPY
	TiyKfTJSXPf3uZPZXbgHbl+xVDMm4YXyeyVnZa7aakhwgKz3cZW4orEez6zlEfsuByTCb6LBSl4
	iNFs3w0xMYdmTTXFEgH6r0uBRO352BX+qY2LwjlyNzWLs8o2s3Ohurc/BRCLF98LzMIMhQ4wtH6
	1UXY9T06Q75utwiDKA8CAnxVftEuK+POIQy2nVMu/ktrodK4jxesnTOiqlGNtS539RZ0/qD8Nnr
	1W/jz22vv0hROuwXfgjcy35C8fEuLKgjrW9nDpcbzOyn94TDx0jKSyT4uUFvvD4WTVdOKjWlqlQ
	D7J6SfJCgWak0XJ7RrK/tf/ew==
X-Received: by 2002:a17:90b:3812:b0:39d:fe64:5732 with SMTP id 98e67ed59e1d1-39dfe646221mr594365a91.2.1789408017739;
        Mon, 14 Sep 2026 10:46:57 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfd9badb6sm590558a91.2.2026.09.14.10.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 10:46:57 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 15 Sep 2026 02:48:10 +0900
To: Gregory Price <gourry@gourry.net>
Cc: Anisa Su <anisa.su887@gmail.com>, sashiko-reviews@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: Re: [RESEND PATCH v13 6/8] cxl/mem: Configure dynamic capacity
 interrupts
Message-ID: <aqgzWnDw5trAaHzU@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-8-anisa.su@samsung.com>
 <20260908104327.DF5E61F00A3A@smtp.kernel.org>
 <aqRuYaUt9qAvPA3W@cxlqual>
 <aqSX3OadID0REQps@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqSX3OadID0REQps@gourry-fedora-PF4VCD3F>

On Fri, Sep 11, 2026 at 08:09:13PM -0400, Gregory Price wrote:
> On Sat, Sep 12, 2026 at 06:10:57AM +0900, Anisa Su wrote:
> > On Tue, Sep 08, 2026 at 10:43:27AM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > 
> > > Pre-existing issues:
> > > - [High] If a CXL device is surprise-removed or a fatal PCIe error occurs, `cxl_event_thread` enters an infinite loop, pegging the CPU at 100% and deadlocking device removal.
> > > --
> > Surpise removal is unsupported. Jonathan mentioned the same on a similar
> > thread: 
> > https://lore.kernel.org/linux-cxl/aqLZP3ORYzCLfSgR@acer-nitro-anv15-41/T/#m8e12567a42b07fae8aa307406e6e017fe24ad832
> 
> This has been my favorite sashiko response so far
> 
> "If memory is surprised-removed, the system deadlocks!"
> 
> lol.
> 
I was just happy to see it only found 1 thing to complain about this
time. Music to my eyes

> (your series is great, sorry i haven't gotten around to reviewing it
> properly, i appreciate the doc updates very much)
> 
No worries, picked up some minor changes from Jonathan and Davidlohr, so there
will be a next rev anyway.

> ~Gregory
