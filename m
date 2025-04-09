Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A47D25F796
	for <linux-cxl@vger.kernel.org>; Wed,  9 Apr 2025 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208037; cv=none; b=r6vdJaOMX/uqGSOSulJXt0wJeAbgDEBo1fFXDJLt+Df7cVZ4zAnkotY48PFJTg2kM5QaRFTf/DkKvZO1lC601HjKshuECwBOhm37oomemu3mzs/M3ebGLwNpbu8/uJPj0fK93+IfiU/cLeF1BrUSo9N7q7i+LNCnu7wb3uuBrGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208037; c=relaxed/simple;
	bh=Wzx10GDhqayaFdXOHw4jy3ji7CvTajL7M2bTNT3aE7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l49BThEgv+zNJhGfvlWUXApuoO4qt2GA3N7TXsdOMaj66R+QA28DasyPzq/F+IwwK8FDU9/YVIKMnahIgKMOkC2iBzwv0aDJYWleOiGSeIyb8ni5BLRwNvQIW4bzBM5umLLKxi31u0LdjPqbRTOko0Tu8CrVR168Jf8fxsUkF3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fRm+ZjvA; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="fRm+ZjvA"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8f7019422so60839576d6.1
        for <linux-cxl@vger.kernel.org>; Wed, 09 Apr 2025 07:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744208034; x=1744812834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e3rw2qng3A71af78wEMO94FcNMmQ3ipn9RO41bkRFgk=;
        b=fRm+ZjvAjde12Rr9Cu27+QUX0KbbnLcYrcVGlXZ+xyvYEYsB7Xi2zF9z4ln65mPKPV
         kwgkpf+BVir0awDfG5hbdgCJSSR9CTHPTobfORet6ZFpS3lgrWsXIniNcCRna7SRy+hu
         BVsqxqn26Qd77nY5fg5Ah7DJVTGGivU1YXnff9+fvE+YeR+BrTzf+M0tFOqjM6jTEgAt
         nNaS3R5M+gYb/S555UVGgbD84Ku8iGZNytlHzd1irdDwgBMbKo/FwTRbrgOwlXRQTBjn
         432bNfryM6sS9pm6aNEeEkGXSIzNLPYTax6fiVgsltpPfsCIszZkm8iF52HzV4nLjaLe
         RuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744208034; x=1744812834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3rw2qng3A71af78wEMO94FcNMmQ3ipn9RO41bkRFgk=;
        b=qzLeAja2b9vAwkevfCsmpXMvI6qE27NwQz/QS/1k/1GdVu7hSlzr3RJkN5oATt0TVz
         mCKsjENupONpD5ASpcuPyst/z3f+QJfBSZcFJOXqvN1OW7a0NtoyLC/MkipN/hOmFMQT
         yj05//OTx8GoilnXi9Hn9yW9Cm7OC+c/vaH91Z9MwxdKpv8ZhTK29uhNj+g/wPyi0J8S
         ZyBu3lGKzxZkrPaAdCbf2yvvnKFZjYQ8zoXLIxVtYvpWb4fw6xd9VlGHQXFvvBZ+O2ZV
         Hq+aZtQUCJFsreL7vZGEggcN0cPrBOdqR581aNTuk3bEfSWHVsNTT5Jy0AO0MNGYl6W3
         b/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCV3DXfR4DQh40RB1Q0/GcFJrUZZse0SYftrC1aHYd6zr/9Stih6rdNKBN56Z0Dbp3kwE4FoKznIDF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6+YOXtglVk4wIUsnDbJtVBSC2Bgj6aZrYwxOcOySdLzdRykbW
	BiDumTaUrhxmCLbv7IXzVMCo2eSmOHkA1g7NXSVvwyX0Stc0g8luJzNZMcGsprT+ahCK93fZ5JG
	O
X-Gm-Gg: ASbGncsjwD+UKmZnItmZTnAx41rHLtrPSY0R3Ui9xt7LDxMxEUL2QmWrsa0Xd+8goQd
	0WRF8iiQirxHNKefm8JVnsSz964kJY2uLaUG8TNXpQBTn5sY3naoQ4QbR9uwk9Bav2m/cT4vIwd
	Oesx+M5Z0Y4SSmN8ZN+oijzSijtJRd+LqGEHcyoc2kV3eqONA+0sYQuM41xEf4KBCaXnPfEpdSS
	JVDT8GXpOqcEe3CSHWBhdO2esdE3mrmGQxB/K2fMJWvvQmx8EAM7FhRlda76CKvtJDukEZU8RVq
	eS7JrTaCLRn4twWyf8ELWOoo9PHK5nQxtn+PFg==
X-Google-Smtp-Source: AGHT+IFoDLzvwTVh4vIq90w+cCwfh/RdpBQ3fVTM9DlQ3x9VL/L+7zy5EOuGWIMlxM544vNtZs8Y0w==
X-Received: by 2002:ad4:5f8f:0:b0:6e8:8d76:f389 with SMTP id 6a1803df08f44-6f0dd10ef7cmr43114156d6.36.1744208033891;
        Wed, 09 Apr 2025 07:13:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::4:3298])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de982388sm7765786d6.66.2025.04.09.07.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:13:53 -0700 (PDT)
Date: Wed, 9 Apr 2025 09:13:51 -0500
From: Gregory Price <gourry@gourry.net>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Huaisheng Ye <huaisheng.ye@intel.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"pei.p.jia@intel.com" <pei.p.jia@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH] cxl/core: reenable Mem_Enable bit of DVSEC control
 when RR decodes outside platform ranges
Message-ID: <Z_aAnzqR-UP9rmIY@gourry-fedora-PF4VCD3F>
References: <20250406112752.1261855-1-huaisheng.ye@intel.com>
 <02fbb2a7-3973-4c7f-8b7d-cfabbb379467@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02fbb2a7-3973-4c7f-8b7d-cfabbb379467@fujitsu.com>

On Mon, Apr 07, 2025 at 08:31:13AM +0000, Zhijian Li (Fujitsu) wrote:
> [1] https://lore.kernel.org/linux-cxl/20240409075846.85370-1-lizhijian@fujitsu.com/

After looking at this, I see why this hasn't been fixed in QEMU.
Basically QEMU doesn't implement the right reset mechanism.

ct3_reset calls
	cxl_component_register_init_common()
		ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
				 HDM_DECODER_ENABLE, 0)

But it never resets MEM_ENABLE in the dvsecs.

I'm not sure it's sane for Linux to be trying to handle hardware that
doesn't itself reset correctly - and doing this fix just for QEMU seems
a bit too far.

The correct fix here is building an accessor for the existing CXL dvsecs
and updating it during ct3_reset.

~Gregory
