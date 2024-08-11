Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB1158A23
	for <linux-cxl@vger.kernel.org>; Sun, 11 Aug 2024 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723407834; cv=none; b=B0fXLixdeodlIRX+KKdPIQUC7PcMNpNd9no0FRWe+rk8zkHj05mWO8N+6X7Yeiz3YjkZGtkbE/SLTlG/8X+RahH2VGSbLz+8PXdTMABAVFg5SShxufbYjBofL0Vfy28E6bZKRPVpPmBRQtoTk4kk934PeZ98nhBsZDKyo2lElsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723407834; c=relaxed/simple;
	bh=My3uMee4xFLSPzftRadt35yXZiJQFUD1laI161zGpnI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R/1J4NksVrqzkgmF3suE4/7OkrWeZAuE/X6U9aeTyD4bLmdV2pCAd0Ajjs93Kb4zDQ1WXad4tl00TTogHFGLOEPR3FWBc1kVcguuFGvOY9iERNhnY2EhVkaVI6qbCA1PRF9pVbLA0bpIR3UQuv8NiJT/TMoOUL3rDRt/MG3iTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0V+HuYqp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0V+HuYqp"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fed726aefcso174955ad.1
        for <linux-cxl@vger.kernel.org>; Sun, 11 Aug 2024 13:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723407832; x=1724012632; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5bxH0HIvgBIX62IPBNWvzW2DcCvjALZOS7xYRmAPq4U=;
        b=0V+HuYqptoMErEgetMT7vEgjAx0aKNtOLaUanC8N7uMQmwCYYYXP4u+nBPgMxwx8eP
         CBVKRw6Jdc5hyil9Qqq7Bw0hVZFzTA036hJHBlTZndSbm7zOJLrI12M3qA0kqXOw7/SA
         G+QdasciWELMuONMezZbkiXhGVuLQghK2gUppQdr2KQPOoCVe+CjtfltHkdhf05bT/ir
         vriN5eeV7dXVcOSC3/imvmtOJdDd+a897c3Oiop3lWfHkVVQ3QIHv5azbdWv2juosN2d
         G2d+OnobOt4NO7JvQSpDZUCSfsbY2b+YtirqUv9ZawzH0IDWCDEQS+DG1ODyw+N/h/Lb
         HO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723407832; x=1724012632;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bxH0HIvgBIX62IPBNWvzW2DcCvjALZOS7xYRmAPq4U=;
        b=QHRXyEmCLentLcSeVt7RNfaJKp1OAawF71RvlEcmlBM0iwymfy3TzN3QV04JMDZYfO
         wU+BRvHH9r/gK4ppkWbOp5AGHzgi0mYqGE6LU80JZ2awmMfELM/+QF0iqxfiIYpwW5sZ
         AojYFpvddGGfFyScV2EhVlFCz8DRduQYdw5tBBp0tfLsQv2hKvllBCWkHF3hycXQGxoN
         Ia/ld8cgP1kabYfq0845fD0f8q/RSxvZ4RJiiF8St+wsHyhhR1z7lrRf94TznnZGKeLz
         FexGGRG0sQCH2HRjWLT+yxoN/yaetHiwZrNplRfricbCZaLIw1fOcGQoiluC5ZdkBQBx
         im9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVU6tntzeu0EOtxvfQ/81N7VUxgr8EMIDwP/fX5dbo0hMgrmiid1uaUWxxU63JhKHWd3ynGOoqJu0chGOOaqi2Wt7fqarLioTQR
X-Gm-Message-State: AOJu0YwV+F6JYhNNGlztcFtlUmwRE14kYg5sCkxnIph0/Zr3BcU/ULTQ
	F4pnGA4QvnGWAFpPappLuh4gOWAhdJEAxPLt/UoZ1pYTKkdPrmUD5lOXeKYTuw==
X-Google-Smtp-Source: AGHT+IFzt+R10qaB9GO91xPW9cFIB/jOO3ilfp+AfFpKq0UrmbSVV8L6fnyPExoeusMwzL1aescGhg==
X-Received: by 2002:a17:902:e84d:b0:1fb:19fb:a1f0 with SMTP id d9443c01a7336-200bbb56b70mr3361845ad.4.1723407831541;
        Sun, 11 Aug 2024 13:23:51 -0700 (PDT)
Received: from [2620:0:1008:15:49ba:9fa:21c6:8a73] ([2620:0:1008:15:49ba:9fa:21c6:8a73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb7eddedsm25974795ad.49.2024.08.11.13.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 13:23:50 -0700 (PDT)
Date: Sun, 11 Aug 2024 13:23:49 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, linux-cxl@vger.kernel.org, cerasuolodomenico@gmail.com, 
    hannes@cmpxchg.org, j.granados@samsung.com, lizhijian@fujitsu.com, 
    muchun.song@linux.dev, nphamcs@gmail.com, rppt@kernel.org, 
    souravpanda@google.com, vbabka@suse.cz, willy@infradead.org, 
    dan.j.williams@intel.com, yi.zhang@redhat.com, alison.schofield@intel.com, 
    david@redhat.com, yosryahmed@google.com
Subject: Re: [PATCH v5 1/3] mm: don't account memmap on failure
In-Reply-To: <20240809191020.1142142-2-pasha.tatashin@soleen.com>
Message-ID: <511c4828-cee9-72a8-8e47-ccdf80011a44@google.com>
References: <20240809191020.1142142-1-pasha.tatashin@soleen.com> <20240809191020.1142142-2-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 9 Aug 2024, Pasha Tatashin wrote:

> When we fail to allocate the mmemmap in alloc_vmemmap_page_list(), do
> not account any already-allocated pages: we're going to free all them
> before we return from the function.
> 
> Fixes: 15995a352474 ("mm: report per-page metadata information")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: David Rientjes <rientjes@google.com>
