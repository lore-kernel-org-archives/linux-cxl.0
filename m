Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FAB2D46D6
	for <linux-cxl@vger.kernel.org>; Tue, 27 Jan 2026 23:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769556723; cv=none; b=dnA3qDeDdzTNQ9aHrovfqV0iKTBBd82vVpAaT9s3XIcZ5ChOZ0lD8W7PwOR0moDED9ss3PnsQCULzpqHdmVwHxU0VFzEKwoNcM4/OECej/HYfqvp6KUraQhdpHOE++ppGDfy4dKaZEqh0VUzHsF2iD6KgeNOYdvDS4RFcQJ4yOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769556723; c=relaxed/simple;
	bh=llUOrd6g/HLx5FAhx+SUViFFF+wpjL4tX6AinX9dVkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjpbLdNbGJHESzIgR00iahI/fDjPvm5h85vBiKhc5Q1tTpgZ/1pnaMM2dcI/sdzv0/lqWAmi+8aOmuwxv54tB3BhxdNjTdnAO9iiJBp7vClx3hxFw3TXtTNJKu60X4+VDXcP6D4ZhfZabnyoEMp2BVvZlmGEJDI8T3wafpTATWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mmxbiW0R; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="mmxbiW0R"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c6b16bd040so696895885a.1
        for <linux-cxl@vger.kernel.org>; Tue, 27 Jan 2026 15:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769556721; x=1770161521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y8ffCxgqfPNNOI1L/bqqAX6TLyKV0Tim54t2cjmn71o=;
        b=mmxbiW0R5WwkhQikr/sm4nX1B09uwDjLzkqFa0f9nqOqzLmc2w9cJLdqFfJcAy66IW
         dvujy/UN9B9lrN4+aPfdR6It9Uja0JluTwRVqHzvjs615LcncFIn4tX3lrv+uIwsi70U
         7MEC2ir8MHqhhNEudBn1PqC59PdBGckli7yfOEFWkLJpwWe8n8mFA6g39v/rvBYEMRS5
         4YdN0pgIa2szcBlj8EdOG4UNtODY6Wr6NhPGmJc4txVQPYGLV2Ayyfu6wUInHRbVIwFs
         QlsxmHgBP1l9pUTKQBDyzsGgP7+gcneyDVhCadnNCZ61fyaI++a/lxmLQjpjE4TRRb/z
         q7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769556721; x=1770161521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8ffCxgqfPNNOI1L/bqqAX6TLyKV0Tim54t2cjmn71o=;
        b=sqgKv/i8vM31veAw1kh45ANaklYeOC5TToVay57eLyuCTXiG68J54xO1Te3io78rKA
         G8b96IrcuqP2xs408G3ESTVQVTl//91M/1AfDa8hU/82WCkGskji8Fr4SfDUhefoT5z7
         ee1p/VHRGcDK3zqt2k64ldjtASImxR4SmlEDw8JJd4PjZymbvMItMofkqSRZesNHI04y
         SgU1cqmsS+KQmIcXlJZdSaF8HkJPYQUFoFZv7c6L1h0HAL+0Imd/mmiliZQTOi8lVTVp
         hL6PHklXyN4sSjtL9/KXZyS8eDbZP4ckX1xjeWhsDCRvkd8xBssa4dbRPuv86yNw3Rsf
         Hqeg==
X-Forwarded-Encrypted: i=1; AJvYcCWdX1ZOaNsMbKEg4zGvsJmgX1P7HMeU1BbF6tNbg7TpEoVQcVw7T65xABeHtXgAb7+KN6+DUGmPWec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPE1IVjhLKSKbFC1kJRfxyVbFX4qQKqiYp9DG3OVNb4jjMVPhN
	bjrKu58wYhe3RbkSaoQUzZUViLYzP7D+xtBp6LJfMEoxABkxDEWe6tSvLrdQAXDpqiw=
X-Gm-Gg: AZuq6aJnaqxviK5vsrkHjieQdD3cQTfOIDlCJB46M5xJR6Ff/TXw/kzoHfEMlB5F5sI
	9+qqBSzfQX6PfjZ30Xyu4JP714JuJhWFCG3FS066h30Sl+egKR7aObtE4C4h3XGG9QghREzLwAQ
	xJzHYwhuecxFtjdAh9LMVnUm+zV9kfTewQugEzvDlCcXrttgKa+A8XA/B7R5B4pf3D1wgVmcibP
	ajkPOXLOVtyPvj3iPHiDVmYaeG7TogIqeQFtCJsRu5YrVic0hmPyVxdKqh2yAxPOkWyAeyRuzTk
	ICD+ra55zpY79JoNwJ2g0CiAsY3kyeW/N2DZ53wU6X7f8HxiKvJnD/4gk/VIT8HruFxpLhF4mHW
	6ZH1n0nUuDYx5WV+BXxePMTslISjGhPxet8wXuPUvvdWEfYKyxWzeSUzV7XsWqNhImnyg5SmWBw
	IWuU8OeoiSHzY3MXl7bvMzGS1gWraHslDXP5JwoG5Q7q6xIz4/Yu1EcB14mdFD2uEfaQctFg==
X-Received: by 2002:a05:620a:1908:b0:8c5:2f70:c62b with SMTP id af79cd13be357-8c70b92d7cdmr423216285a.85.1769556721349;
        Tue, 27 Jan 2026 15:32:01 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b98539sm71997685a.20.2026.01.27.15.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 15:32:00 -0800 (PST)
Date: Tue, 27 Jan 2026 18:31:59 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH 3/8] mm/memory_hotplug: add APIs for explicit online type
 control
Message-ID: <aXlK74ZlUf76nBE_@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-4-gourry@gourry.net>
 <b3d435d2-643f-4dad-9928-bc7fb5080181@kernel.org>
 <aWfR86RIKEvyZsh6@gourry-fedora-PF4VCD3F>
 <4520e7b0-8218-404d-8ede-e62d95c50825@kernel.org>
 <aXLCAtwMkSMH3DNj@gourry-fedora-PF4VCD3F>
 <20260123182526.00005ee8@huawei.com>
 <aXPIGMVAvVEBgFhJ@gourry-fedora-PF4VCD3F>
 <793fb531-1fda-4de4-b73f-fb46444ca613@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <793fb531-1fda-4de4-b73f-fb46444ca613@kernel.org>

On Wed, Jan 28, 2026 at 12:06:01AM +0100, David Hildenbrand (Red Hat) wrote:
> I'd go for
> 
> 	EXPORT_SYMBOL_FOR_MODULES(__add_memory_driver_managed, "dax")
> 
> (or would it be the kmem module?)
> 

it would be kmem.

I'll let the accelerator folks argue for loosening the restriction for
OOT modules, for me I think this is sufficient.

In the long term, for the private-node set, i think this might also be
ok, as the intent is to only allow "enlightened users" access to private
nodes anyway - zones are less important since the driver still has
a say in how memory gets moved there.

(e.g. compressed-memory is a demotion-only target, which implies only
 only movable allocations can occur there... so zones are mostly
 pointless and the whole policy setup can be ignored and the original
 interface can just be used)

~Gregory
