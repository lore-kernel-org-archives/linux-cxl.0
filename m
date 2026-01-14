Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590D32E92BC
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410462; cv=none; b=DBB06JNf+59sNj5F8lLeLqkeX3nI3qlFQropyguo8cM+MzSxlOS81E4bTuOQUduUuVkFnIQyO2L2g1fSYNFy2uB3rVUWSM+gD7y0+GsrYlkowcF2U7LUcxio4FkqcKgECSnSiCPDQrh5UC3xKrRbaVyxmjK4lwgBT0IQ1JtkpR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410462; c=relaxed/simple;
	bh=uQspQgAYPv3Cb8Bx+9DY3tUvsrynhhsH1nDv4+whjaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjw+L39IlypFc3sJLLJ6DHO7etA8QszkUBtbX8nUaVfq1r6+BOGvL/ryWsmun5mgyMv3rouyIS104HqnDanwJ0IDlVv0mUPFCOstBYL188s50RLN/22AUDEr+vFS6MoKtSo4mUIIl/IHAabytAQRt2pY0vlJbltsL4AIc0NkMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=X0p2Jsj4; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="X0p2Jsj4"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5014b671367so10045601cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 09:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768410458; x=1769015258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8RFOwDQBVEpg9rej94TvEUAdCP3OvqZFUczDhVsj6Jg=;
        b=X0p2Jsj41aYN1TLjb+hFTFZQs2xA7daeNESC1fBlnax295pOoIKGRVGWdjfFhNP7r9
         G/0G72xfyPAMBN4HBLHHVOx7Dcv7a5ssI/hsJwQoh0oIJtKF1ZaXXd/3O1j0lqU8kSjO
         iHobD3017v+PKJX547LLSsMTpUKzkU/Lez0vCCGiD9S8Pu0vewUf2OaChTIoAuSnAbeU
         7+MaFwHAhKBDTudJU5Iec93kJExuSuPyzmv6+sHReFcp9eKfeMqMnsj73Y1P/yCIq3U6
         CL2+G1YaS8PJ+ysRwhnpHRNahXBavufJmJHwfnWnLJJO5A3YiH/Wt2rONAAaNG/kGydK
         cpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768410458; x=1769015258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RFOwDQBVEpg9rej94TvEUAdCP3OvqZFUczDhVsj6Jg=;
        b=kn6u56ERicQKogElClyi1ayrt0fGz8W0vcdVmDtMsmS6JmCeBxoYH1DdpHfQj7Fzy6
         NvOcJTKJQDG5mIekPsUsnaHCY12N0hv5e1eOtzeYJQuUeKkfvdj+5i1OGzx3yyxt4fXm
         wKFRuHroppf7pH5yW0hPUCPbFbI9ttkCw6hQcHnMR3V1C5itMtcatn+pJztEWnF2p1/e
         C08GMgzCtjf+blX40AGzkn/v84sCKY16iNGQKTq03g8shF2UxN5kgc4XDlEhbVt3AP9P
         wOpCN6WoHTLfLTLSe47c7Wjcs/eP+yp6e8dGdhlNL46aHjZ8lBRJI8QG86DdajdauzL1
         o/sg==
X-Forwarded-Encrypted: i=1; AJvYcCV35VAnxoaT8bTUNh2iEhka7Ch6fazXiX2JtFS2ubfCOHFtOmO99LUWIQDniyHhK0NY31gO2/Tp67w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUI4huVhxjiHXgwnX12poX8OFC3packcZDWU16c1CPvyeMjmXu
	zWw2ZUwReycnTL12Fjz06vYf8FikCyyHWwnlkUbOfvozLlqt3ayCTFe+j1/5C64RMYM=
X-Gm-Gg: AY/fxX7UKmeGwjsjl08oGXt46belFJRp7mV2hu8PtgRC3DUkxrrKeY4s+VvToMGbdnj
	/Wz8yiSB5GGQMBMWCcUltI32z3mw2cxVMlLJNIGEYuyo8Qgfd12TJdMMBPan7SrN1beBhda645v
	VtqHbeUT33hy5YhpO3zX2nNuDYYguM+gTGwsTBS4HPocQxofMuFCkci8CfZVkEpllSdXJg9P/vQ
	/gz90iR2hzbBkVHgNcSjxoU+iLbn0Ht8cxpExPOWPtT7EelT26GPtri9jPB5GQnYZ/SB2z7CiAV
	vFQjnyPGH51ujD5YHvq8/CQkso30a7sdDyEwUM7YZqVLaCQKFMUcUes37lbziU/KROzBGKpzM1T
	Ao+VHqPV6rGsL9/uEgQL1Q6dMg6YDo97vo/KcUQ5zwPiH98Dl+Q9BgQKxpeFuCcmoS+Iwfj7lqD
	Z0Z6WmQjX3W3BIzNp+kgp9WWolTU/LOkRmtWLgsUZJIgd9ZS85G3pbJseR3YOxTcwzyHHyvA==
X-Received: by 2002:a05:622a:4203:b0:501:3c88:131 with SMTP id d75a77b69052e-501481f8ff5mr39550561cf.22.1768410456999;
        Wed, 14 Jan 2026 09:07:36 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148eccd7fsm17076341cf.25.2026.01.14.09.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:07:36 -0800 (PST)
Date: Wed, 14 Jan 2026 12:07:03 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 8/8] dax/kmem: add memory notifier to block external
 state changes
Message-ID: <aWfNN-hy64bGw6p2@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-9-gourry@gourry.net>
 <d1938a63-839b-44a5-a68f-34ad290fef21@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1938a63-839b-44a5-a68f-34ad290fef21@kernel.org>

On Wed, Jan 14, 2026 at 10:44:08AM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/14/26 09:52, Gregory Price wrote:
> > Add a memory notifier to prevent external operations from changing the
> > online/offline state of memory blocks managed by dax_kmem. This ensures
> > state changes only occur through the driver's hotplug sysfs interface,
> > providing consistent state tracking and preventing races with auto-online
> > policies or direct memory block sysfs manipulation.
> > 
> > The notifier uses a transition protocol with memory barriers:
> >    - Before initiating a state change, set target_state then in_transition
> >    - Use a barrier to ensure target_state is visible before in_transition
> >    - The notifier checks in_transition, then uses barrier before reading
> >      target_state to ensure proper ordering on weakly-ordered architectures
> > 
> > The notifier callback:
> >    - Returns NOTIFY_DONE for non-overlapping memory (not our concern)
> >    - Returns NOTIFY_BAD if in_transition is false (block external ops)
> >    - Validates the memory event matches target_state (MEM_GOING_ONLINE
> >      for online operations, MEM_GOING_OFFLINE for offline/unplug)
> >    - Returns NOTIFY_OK only for driver-initiated operations with matching
> >      target_state
> > 
> > This prevents scenarios where:
> >    - Auto-online policies re-online memory the driver is trying to offline
> 
> Is this still a problem when using offline_and_remove_memory() ?
>

I suppose this commit more than the others is actually an RFC.

DAX might not want it.  Other drivers might.  Now at least I have the
code to do that.

> >    - Users manually change memory state via /sys/devices/system/memory/
> 
> I don't see why we would want to care about that :)
> 

Absolutely critical if we have something like a CXL DCD region that
wants to try to protect hot-unplug.  But that is probably an argument
for implementing this in a cxl region driver than DAX.

> >    - Other kernel subsystems interfere with driver-managed memory state
> What do you have in mind?
> 
> Not sure if this functionality here is really needed when the driver does
> add+online and offline+remove in a single operation. So please elaborate :)

See above - so yeah I'll probably drop this and come back to it in the
sysram_region driver in CXL.

~Gregory
