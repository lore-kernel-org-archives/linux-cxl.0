Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0615C18E1F
	for <linux-cxl@vger.kernel.org>; Thu, 26 Dec 2024 20:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735244366; cv=none; b=HY/WFMk7G5WcbCF6yjSK3slsLTUxEx1uRWbfoZqxDZhOc7+0WBSdiDuqW+E1KOnJ93qEqTV2t6OFciFJ7jVndmZtPwX2eR0zM6KGC4Vp8ebTm3BTu3PcBO3FcddC5iGsgWEikmzcy2047Qa9BuvgufVhO0M/6Y1LXALik7ULY1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735244366; c=relaxed/simple;
	bh=lRgHdMNwk8t7SFgHlM9cwhzzs67i3LH2uk2gnqvP67Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KNyhe0husODXbj9D+BDMJ7jNn6yRTHSxJDMP1H8PxuJShJH7fZVDyUA9xTIJ4dRQVZK34ndI2aThKogjzeb/zgP+jtr9axegf3uUAKuVf+oLmE/ZR3OoxeVbvJyyPJ2NAc/zHdAi8gV0VJhzHm0sAPiYbpq3wAOtQqrLpPnHXak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Hc0Fi4dK; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Hc0Fi4dK"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6eb531e13so330441285a.0
        for <linux-cxl@vger.kernel.org>; Thu, 26 Dec 2024 12:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1735244364; x=1735849164; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qz5ytK1GRdvKgO8e6oKZGmSzgE/hU2itL0CRU+M0PxQ=;
        b=Hc0Fi4dKJuxxmDRKSnEsLZ3L4WxyNLPznTuINNBbWWXD9O+pEBCsdRlyRVGL3uuLdn
         9JVOocNTNxQr4QSHJXAUNZwxASdyFpCa5ZfShoNCFq5O0jM1XbiuZhpdek5UCxQXyKM3
         sBdhItzleMR299Z2dmQnROqvNDD0tn3UFTfnthb+tGg8Ho0k69Qa8ZKijJMkR4NDRE+5
         Yw9h2epGR+mztTpCZWqIfvDFGvuIEnagn9HzLDuzE0NwY6yGZWi47Kz3UYOUkRfGaCRn
         4CWK3LIg5wXPTtpbJPIRjp1Fc3tlGOgE5hR3TDXJ94dFQln5YPDaejrIrenOV01j/hTW
         2KBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735244364; x=1735849164;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qz5ytK1GRdvKgO8e6oKZGmSzgE/hU2itL0CRU+M0PxQ=;
        b=tFmVYWyDP+PoqF91guGWyCpglh1GSqiOQNcxNnhC0doAlmpTgVQRIEssWZhix2gGzX
         JQ4v65/orZqrDvWfwW0gIsOdsv7cIoiP7w1ZwldEEK/G4CMOu+yI+YJanl5ZjjN6o4BJ
         IuLBkUZIS4Z6LiaFHQAUwa13UPo0hwghgFZcpEU47onuknH8VBzILuRsMN3+UlP9m1RY
         uHQnPGoC3bxZSWAb6NbEilE3fx9Vst974bHywgFUBNd0QeAloVCrx35Tc9qTT1TD9C19
         RJYbVUP1/xk5FncVRIrdYgyDW1RyXVDi8n7H7hubP8plUNVun6h4ZAoaJEJOmXelWcxx
         w65g==
X-Forwarded-Encrypted: i=1; AJvYcCWPQ7JdRGEQzrYtaaPWwZKh7JY4axLOn90xZ4Or3lbT9qQ0BsCvqXG30HVnyT39t7ufvrdF1mawfzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/V7ZnmJkCL40Vec3fMZJbxwS49BgDvuGzYlJq0UwjtgalTcKQ
	hn8hw2W7hSKL6BxxemKsUhhN5cZI5W1jpRd1cDeJfDaXQtIWs3/8MQKicGJpeU8=
X-Gm-Gg: ASbGncuzWOKDefbXHG8JxlNSZ9OxTISpkz96mNdcJ/4XezIyQLwqYXQ/E/drNWtQM2c
	OuQAtmnwkj3bZWhxVIRQQlBB5ynHwBgUirZJqicFbyvJDrSNhdAIctT941RR8GH4QniFrLeq9jU
	gYDI1jTqQmJMP4WJx06+sLFKtqHZ1Oz1+LuEdLHRg66O6mr2A6g62SMWRK9oNDiIBUKlbDYXQye
	dwVsJ3EgEP5UMnxf/SV3SLN5uRNS+C+FsnJ66JmOKKlSxuAtOW1lF2ZAE+S1svJ
X-Google-Smtp-Source: AGHT+IHwbSBUELCWH88to3eKbIbKFQlIGmiEO20KuDJPlMSg8m7xY1XIjb3s2ATL2I5p1b8aOzoeHQ==
X-Received: by 2002:a05:620a:4551:b0:7b6:6c46:55b with SMTP id af79cd13be357-7b9ba6efbbamr4034804785a.7.1735244363986;
        Thu, 26 Dec 2024 12:19:23 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F ([184.169.45.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2d1054sm648499485a.32.2024.12.26.12.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 12:19:23 -0800 (PST)
Date: Thu, 26 Dec 2024 13:19:08 -0700
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [LSF/MM] Linux management of volatile CXL memory devices - boot to
 bash.
Message-ID: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'd like to propose a discussion about the variety of CXL configuration
decisions made by platforms, BIOS, EFI, and linux that have created a
complex, and sometimes subtly confusing administration environment.

In particular, when and how memory configuration occurs have major
implications for major feature support (interleave, ras, hotplug, etc).

For example, treating CXL memory as "conventional" without marking is
"special purpose" may limit the applicability of certain RAS features -
but even marking it "special purpose" may be insufficient for 
(coordinated) device hotplug compatibility.

Another example, RAS features like POISON have different end-state
implications (full system crash vs userland crash) that depend on
whether the memory was being used by kernel or userland (which is
actually somewhat controllable, and therefore useful for
administrators!)

Some of this complexity stems from interleave settings and how CXL
memory is distributed among NUMA nodes (1 per device, 1 per homogeneous
set, or a single heterogeneous numa node).

Specifically we'll talk about
  - iomem resource allocation
    - EFI_CONVENTIONAL_MEMORY, MEMORY_SP, and CONFIG_EFI_SOFT_RESERVE
    - e820 & EFI mmemory map inclusion
    - driver-time allocation
    - hotplug implications
  - Addressing
    - SPA == HPA vs SPA != HPA
    - Boot-time configuration vs Driver Configuration
  - Interleave configuration
    - Platform configuration vs Driver configuration
    - PRMT-provided translation
    - RAS feature implications
    - Management implications (hotplug, teardown, etc)
  - Linux Memory (Block) Hotplug
    - auto-online vs user-policy
    - systemd / typical user story
    - Zone-assignment and Poison
    
I'd like to lay out (as best I can, with help!) the current environment in
linux kernel, the "maintenance implications" of certain configurations
decisions, and discuss where ambiguities are present / challenging.

I'll add some additional follow-on emails that break down some of these
scenarios more in-depth over the next few months for some background reading.

~Gregory
