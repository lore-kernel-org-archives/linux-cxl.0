Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A77340D90
	for <linux-cxl@vger.kernel.org>; Sun, 12 Jul 2026 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783874937; cv=none; b=tQEiGZ1qzbvYAm6sHZKLjh4Dj7ddw3rGbBj7sHstcCsAiIF03nNOjcmH7Eaq7iIdQSRU1EqEkTlYUB1NnjdKTQ/TnLM4/T0D7VyVDnehLYceGVmV7+xWJsUw9wiu697+lImrEuw2+Ei6Qllry3Z3sJS8LK57IYrlfCG7J8KW0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783874937; c=relaxed/simple;
	bh=Qt4v/dZ/atl2InBXlF6Qg0mek0k2Z3U8e5b5n5VxTGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YC68S0JpSPCoU+scdqGqDbdsS2A6v3K6bkZwnYkZz51+ZoW0xFFhq3kYrwLufMw+T7iUW6dvR/t6NcWKA/rjS6NTCJIZ5Uv0aSb37a5+d5fqztmAJ53hyOM+duxsAKFRWYl5AIKVxtSICeTE4x8xhro8JlNqJPQOOZeQgqk95OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=exA3xckI; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="exA3xckI"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c05dcdf49so26559891cf.0
        for <linux-cxl@vger.kernel.org>; Sun, 12 Jul 2026 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783874935; x=1784479735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jgHRZ2oQs3owZnO2hrgFCKNrpUU4ppVoDgnNpxTspCQ=;
        b=exA3xckI/kwOvLjpG0265GkWKjFMTEExa03ZRLlisFWFPJgMrfb5xM0MRliv681WIU
         tfpUoFytMgOC8WbEMQh1al1W3ZRT7YGNy/QLrDnOBOZ7+CL1ZoLPKL94lwd9+/UXGwIq
         cOn0qemgQaiKz4Vj6MyKnebBkRhnCqJcgQK8qQOT1TWGlG/kwEpRt/D2G822FlmIU+Ys
         HLTGYpsrY3LOn6Ykla0pbYSNnc5jAVspIrzBR+c0128z1wn2Ay/GoSmE1j9wW4VWVFF7
         XjnjDLMUPUpDE4yGm+7pr0ho3L6WL05aoXXC1RSbzo9DnQgTqZwhB6uvpugxUuhLbnaq
         1RNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783874935; x=1784479735;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jgHRZ2oQs3owZnO2hrgFCKNrpUU4ppVoDgnNpxTspCQ=;
        b=rSMMAd5i20SS2ZnHY5I6V+0QJYS0jO8JXxrGXHgzXhYRzMiuq5Jt+8jI9H/+cQp1rX
         LE7NtCf2bLWg7pvj35m0vFKYb52IyWnZ3qZL/MioA01kfTk91jXb+jMQQscGVgoJOe/t
         1ZflkEBA/Y1yvlI3TerqLXgL4TtxMIYBahglP/Fwm2zyLB7SwbptCO+vwFSVJExO34Mm
         b94+9etaPItTLHDjicQhaFr27SP2Xx4IcwkUIL7OfaURg81az3CsfPgL4XD7fXzKCbjd
         tnJ6JTC+k00Idnztt+tLep7dvE0ZYY8e4b9sBot3oRJCwwtHuJUW2xccXJjeXAnWSykH
         sgNA==
X-Forwarded-Encrypted: i=1; AHgh+Romte+ujZ9uXY9nHHUUsAFWYPdBu6zaV4rIzW1hC7JAfC25pr7kxxI3PJ+ITgUgSkjlq+l2Avf93zM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2J++/e/IDl1omOeNZBpMWYZYRNTGa+E9jX+Q7f6tO0IrFPOc
	AyE/2bqN3w9HKlMnhehLzZxrYxBD+deaqD41dhONIjaaMyi96wQO7g/9Rqffs45aQU8=
X-Gm-Gg: AfdE7clohmLZeNTsLWQZQS9SNRJT5sGcs2ZOTihOeHdGA0x/PEMKE/FEVNTrQGEbBBs
	kGe0uwDqkFFegpZHW+YqN3p0aGV6vaL/SX/gK1gDz9k6MwxzhhAYiOkGkxZwcilp3vz7YFPnwVu
	ojMalnzTY8i4cAzysxdJFImqY21nUO0sJ/MrhaTlDo4bHZYiaExnEZzHlmkKc22Bb/GDvirrKEZ
	Yd3X11V+0Nsij4XavwEVJqcbhFHhrTuE14vFIHYywXJIhrdTF5dWZbapw8YYIIOSqp1TgFJMVv0
	QMdd3AII0gl4ywlejCdoxFXRAZTCMuE+OZugJKO+IzRboXhOltUUUkDsQwjZXzmaqGVeBLcutVq
	WM1zq1VSd9YB4JVKTIFa7bzd58G75hRRxdBx6Z6GpttXlpxkTdWII4T7fN9SGelnblG6Qgv2/1P
	Ow3pOlda2UVb74q7zGUP2dAPiiLkQKAgHYIsslbvQ2O1NamoZyJbqV5GrnjyGWcgl6Lumt
X-Received: by 2002:a05:622a:7281:b0:51b:f98f:ea5e with SMTP id d75a77b69052e-51cc9d5d02amr30044441cf.22.1783874935089;
        Sun, 12 Jul 2026 09:48:55 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caae20a40sm68575071cf.15.2026.07.12.09.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 09:48:53 -0700 (PDT)
Date: Sun, 12 Jul 2026 12:48:49 -0400
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, nvdimm@lists.linux.dev,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com,
	david@kernel.org, osalvador@suse.de, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, djbw@kernel.org,
	vishal.l.verma@intel.com, dave.jiang@intel.com,
	alison.schofield@intel.com, akpm@linux-foundation.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	shuah@kernel.org
Subject: Re: [PATCH v7 00/10] dax/kmem: atomic whole-device hotplug via sysfs
Message-ID: <alPFcfjlzSHYk3jA@gourry-fedora-PF4VCD3F>
References: <20260712154505.3564379-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712154505.3564379-1-gourry@gourry.net>

On Sun, Jul 12, 2026 at 11:44:54AM -0400, Gregory Price wrote:
> The dax kmem driver onlines memory during probe using the system
> default policy, with no atomic control for the state of an entire
> region at runtime - only by toggling individual memory blocks.
> 

Took a look at Sashiko reviews.

All are either false-positive, pre-existing issues on isolated patches
that are actually resolved by later patches, or something we previously
agreed on (WARN/pass in phase 2 of offline_and_remove_memory_ranges).

So series is clean as-is.

~Gregory
