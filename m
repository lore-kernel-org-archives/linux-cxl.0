Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC3B4399ED
	for <linux-cxl@vger.kernel.org>; Sun, 27 Sep 2026 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790536821; cv=none; b=X98+xQBc72MZ/vPMQ8GPyQveLHsURx2qqLi0pHcDn+71z60Z/uLdmO1+RBDQmmuJszVIZsUOYAIa2g8ljQXEjkuWh1LH/OVgFtYSd5UAg+rH4Pm5Bk/Pht6i9SsF+i77bZVoev9ZiuYo9BBtqfXMGh9FUI9yoAZxH0uW5vh/K+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790536821; c=relaxed/simple;
	bh=Dsi+PgjO41x2VtjYExfHIy0tp/9a5bzvYlJ6M6e6TFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mU0Bgm4HcxE1jQvCozbVtEp89UyLqBfZzMc6vmmxg/HxaC2Dvr7JM1MMvEeX7sP56OTTYJRi3CitVWfUzEIp+0ZIoE09C7mXgPiQi1EX1tBBbW1Rmh1YXpb8I6KPQZ+3jrsrCjbm4HQNwjmZWbYwcPFqQTsgAlkxAlcrq4L5sec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwONTkPh; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwONTkPh"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ce364488dso6352395e9.0
        for <linux-cxl@vger.kernel.org>; Sun, 27 Sep 2026 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790536818; x=1791141618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MCahJ3O+tXX0CfGzclDhULcHGoByJJvACQgWnDRt+Os=;
        b=MwONTkPhRbVr2zKDbdRn8p0CqyWMV4+R2B737dgSDbjBs8C16mXw4RZE39jHm57gSI
         4LPCUebCeTI4ngHVuF/QGCfBM/CwE79njXVVMyMrTIneBB5dLeZGxChiNHElvYdJKdgb
         iHgjSpCZyWFJYCIZGEJcRV4esW5SbnRH5a50EzK946sOvoXND+ge8wwqIF+1AHOaNxrB
         jGqrniW2Dv8n/oDHYvJHwwafHVZoU1ZRTS3Dr2ehhjcYXmrPo/ObWaL0G2U4qLo9W+0h
         QNHFgEM+LpOVzIS2JWdaDh3lxD9otZnOZJ6nMtiwHfa+vlnHjIm58a/VmgsMEz3VY4sX
         4QNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790536818; x=1791141618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MCahJ3O+tXX0CfGzclDhULcHGoByJJvACQgWnDRt+Os=;
        b=O2w2DElINz2Xv4iwH+zHfP+RWjzsVPicaDSSQ4m3dBzL68M3afG+xIglKCdet0oqmX
         HzrGLRVvGPJCBSiYTYYnLC0wBdeDWAHkuDUPah+XZ3Hc3O3qiY9Sz9/D70soNUeBN1JO
         IVH/ya3XvRydwah574LETjs4O2tLiNInRlHAttmXHkpVJePLSjy90bizsnCGIdj57Nlm
         j0a6ffIAFA+tcYDmUN+j8cY425WmEMf4DkUljICxmBFAe12XIfwPpZB8oMfrQltITzef
         8aON954p6Sa6pvwlRyz6WWjcZWjb8xZm0Cx1eWy7n8pALZ6G+XTaYB0Hu8Gi5iWnYrtn
         y9Ow==
X-Forwarded-Encrypted: i=1; AKwUvBwMsoC9W/Rctt2dh1iFgiagTe/70vVf2w+Iw0AyRni/whjiVkz8nqK3m+Eg1LBLMHBxHDDWPtre8GE=@vger.kernel.org
X-Gm-Message-State: AFuF++mV0rT50oX9zD+7WedU0wSUSrWC2kTrjoeQj2osYzfnwx/03U98
	OaNeO2ORBEhKkGPRSi4te+GYtQxGYTlhu6u/ZjldO5TGAmGpzcFZQv3v
X-Gm-Gg: AYBFou2Shvs4cj10yliiTainzzKvvvcFmlslj+fI0i7+LC0wMXnXd8YzyvEnsAVS5kL
	ViGfvkpEHwuDllQuC+FiAd/nAhwfpkMN2gmjL2Ry2xSo3S2wbf1dqqpkj04r4I3/sLCB4akVWS/
	SNF62g+4+ZIfAk5LYO+miFjA8dcR+vsxnnxXKIFr32bW80312oeUAVkRSnvYyjxOB4ZtkSXyxOc
	deZJwH38DUqfAJHwyPKGOo7N0rfTpEeTcU+MeB7HzpmpVOSdZgmbk3bIj1x5X+Of1d7Iayj12rj
	Hv/qxQ7QOulQEISOJJDiqpysh3Fk6ofAyk4gX0rKMQxMJ8QVGhP9YYRSez6iobRrSk8U3UhuQiB
	DXduvbLWB20EKWilwqJrTK8bNKfiBzDBR0zsQvrwAd7m6r+wlfu61NfzvWlI2QQg3kcjCJ3rfty
	gi3GmNya/kFM2yKyAqQxK0W/gSp1g8C6aVUJP2auJ2mX3d2/rS3J9Bp+R3cR0CGuoNiF2B/CHZK
	XgjpzWEOhZy4tIte+hNpmL72SHW3FjcOfVmliOEdHbJSlNcJx/Mr8KtpSk=
X-Received: by 2002:a05:600c:4f89:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-49fe66c80c8mr198488725e9.2.1790536818014;
        Sun, 27 Sep 2026 12:20:18 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0017998dbsm117774805e9.14.2026.09.27.12.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 12:20:17 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	baoquan.he@linux.dev,
	brendan.jackman@linux.dev,
	dakr@kernel.org,
	driver-core@lists.linux.dev,
	gregkh@linuxfoundation.org,
	hannes@cmpxchg.org,
	jan.kiszka@siemens.com,
	kasong@tencent.com,
	kbingham@kernel.org,
	liam@infradead.org,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@suse.com,
	osalvador@suse.de,
	qi.zheng@linux.dev,
	rafael@kernel.org,
	rppt@kernel.org,
	shakeel.butt@linux.dev,
	surenb@google.com,
	vbabka@kernel.org,
	weixugc@google.com,
	yuanchu@google.com,
	ziy@nvidia.com,
	David Carlier <devnexen@gmail.com>,
	devel@lists.crash-utility.osci.io
Subject: Re: [PATCH v2 10/13] mm/sparse: remove SECTION_MARKED_PRESENT
Date: Sun, 27 Sep 2026 20:20:13 +0100
Message-ID: <20260927192013.144672-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921-b4-sparsemem_cleanups-v2-10-54d81d65e125@kernel.org>
References: <20260921-b4-sparsemem_cleanups-v2-10-54d81d65e125@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 21, 2026 at 09:59:02PM +0200, David Hildenbrand (Arm) wrote:
>  enum {
> -	SECTION_MARKED_PRESENT_BIT,
>  	SECTION_HAS_MEM_MAP_BIT,
>  	SECTION_IS_ONLINE_BIT,
>  	SECTION_IS_EARLY_BIT,

Hi David,

It seems dropping SECTION_MARKED_PRESENT_BIT shifts the other section flags down
one bit. crash hardcodes SECTION_HAS_MEM_MAP as (1UL << 1) in
pfn_to_map(), so it now tests SECTION_IS_ONLINE: offline and
ZONE_DEVICE sections no longer resolve to a struct page. makedumpfile
only checks bit 0 and is fine.

Keep bit 0 reserved, or export the bits via vmcoreinfo?

Cheers.
