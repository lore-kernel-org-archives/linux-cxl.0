Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A97015B55C
	for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980721; cv=none; b=Juj7OzyeIEWy3RGaQrnwI1atIPLiUihKBtx5uk2wsfH0t/J2pHvp9rRxopBFRGmRJJMpuxVY/nSJ5sYGwP/otwSNa5zZ1Xso5+7cqq+rVI2qrwB3ct11c1onvx8GmoCRu0w4hTLFO9Pezf/8CC9R6igsqeyQaYJVVTFFAfDnkqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980721; c=relaxed/simple;
	bh=fSGHgTL7DafFruy7KXvRfS7CpgJL49suCycxjURplVs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXjKaB8lXP6uoPZ4YWLrAppwOBhASMe1oQ1f+vVyZUOIs3YBr3Lq2rGFEyCy7K7+oTfUnhonXVauLEodF9FUgPP2XgmZsxw1oUdYEDc3FjPhRolSAx5P9JCG5MWBG5odrT+8laQPTC3rfnVz7HFnnZpCLtEbWyV26o2KDmBJLOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5/eGXcr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5/eGXcr"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ece8991654so167888b3a.3
        for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 10:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713980720; x=1714585520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UUisX1hzQQS8Kei+sBKavJsP0CqzohBLBY97e3PxcHo=;
        b=R5/eGXcrTgsPkKIpS5lZjzyo2UksMVBKdJt3pkmGhSSaSInFSgwyx2fy8rewOlV4/7
         MgnJ7vvW5L42tulb0nihLwnObGioclORsEUs4siLyTlO8Yic66fMFCe2td47t4qNBCcw
         Uv4ppo1Ks0GhIu38qPBJdVlxUF+S7AP5G/QPLXXJL0C3eKBaaZbO9hwfozud4JoZ3pTq
         4900aguZK8p7+mqEdS87MK3moJE0ZpEAR72ljyNX/3fud8ogyIr2qqvBs6aFLzAsVx/Z
         xMD2Rc/eAF45BUgEBCU0eMfy1Rm4jie36zxdlLfDv6AZWCs2594rvfrYZpn1p+UNdheV
         Y76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713980720; x=1714585520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUisX1hzQQS8Kei+sBKavJsP0CqzohBLBY97e3PxcHo=;
        b=biChYuOC9TpeBe4kyRYMcrfZWTkquM48z0Gh/Uuc1Ag8GaBQd8j9fQOB2oxfnjiyKk
         ZE6JbmevFwu/AEOIYW3NdWye4AYeIfFmKYlCIjUn5umuR89LSrzlzUnh3HtvWy1X8A0Y
         YJMoninNru6ZKNqWOnOOd65E3YSbT1TbtuyznWDUbNZExfV72gvRg1bdb/l/AoJ7xDp2
         pNC74w7JEqP3thVKpaAAY83/cCtDSMPkZFLAVoAsObn9A0z1mMqU3NDsL1B1Zwabi/QM
         Aj4wLW5Bt1OCVrKlIi7JhXcbJSKAn/FWdFWRwVxszIVBctHHodGIkd2PAjBzFRwjkGIF
         +1Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXl2Cac2cCxhVK6othq8dVYcGLHdwkn/zIOWH91fyg7BtPDvNkc6hNLvuseUSG7fMBTtVsjL3Ti03dmg1G6STu//eLtOBo+Liw6
X-Gm-Message-State: AOJu0YwSdu4M5yIc8Gc8/B8jmtQbJ8T7HtyX64yX8KbcfFEwpntUmsx1
	WEV2SxBrf/i3rBWfuqVxvg+wKAXEv6Fy5FuASyzp6mBVgfPQr6KZ
X-Google-Smtp-Source: AGHT+IH08iEcxdee91ZKCmcfD34eF58jPYiw7s63UPDDko2fgLX4+RBXbx9vbYx5kantH6TLzY6kMA==
X-Received: by 2002:a05:6a00:218f:b0:6eb:3c2d:76e0 with SMTP id h15-20020a056a00218f00b006eb3c2d76e0mr4250172pfi.11.1713980719871;
        Wed, 24 Apr 2024 10:45:19 -0700 (PDT)
Received: from debian ([2601:641:300:14de:b318:9476:706a:e82a])
        by smtp.gmail.com with ESMTPSA id f26-20020a056a000b1a00b006ecda086db2sm11734654pfu.110.2024.04.24.10.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 10:45:19 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Apr 2024 10:44:54 -0700
To: Markus Armbruster <armbru@redhat.com>
Cc: fan <nifan.cxl@gmail.com>, qemu-devel@nongnu.org,
	jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
	gregory.price@memverge.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <ZilFFhySKFE6FmYC@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
 <87a5livrdr.fsf@pond.sub.org>
 <Zik88BUMsMEFb0Nr@debian>
 <87pluebrk0.fsf@pond.sub.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pluebrk0.fsf@pond.sub.org>

On Wed, Apr 24, 2024 at 07:26:23PM +0200, Markus Armbruster wrote:
> fan <nifan.cxl@gmail.com> writes:
> 
> > On Wed, Apr 24, 2024 at 03:09:52PM +0200, Markus Armbruster wrote:
> >> nifan.cxl@gmail.com writes:
> >> 
> >> > From: Fan Ni <fan.ni@samsung.com>
> >> >
> >> > Since fabric manager emulation is not supported yet, the change implements
> >> > the functions to add/release dynamic capacity extents as QMP interfaces.
> >> 
> >> Will fabric manager emulation obsolete these commands?
> >> 
> >
> > Hi Markus,
> > Thanks for reviewing the patchset. This is v5 and we have sent out v7
> > recently, there are a lot of changes from v5 to v7.
> >
> > FYI. v7: https://lore.kernel.org/linux-cxl/ZiaFYUB6FC9NR7W4@memverge.com/T/#t
> 
> Missed it because you neglected to cc: me for qapi/cxl.json :)
> 
> Thanks!

Sorry for that. This is the first time I made changes to qapi/cxl.json so
missed that.  I will cc you when I sent out the next version.
Btw, thanks for the review. I have replied to your comments in another reply.

Fan
> 
