Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793256321;
	b=dt8c0IQSVQOAc906VxPaun3s8Fl8/EjPrn+S2BK11lve6GvtroEz6T5IOzHeOg7wxuF1
	 LBt0O8G50iEL6SHF59t424Ha1kxTm3+34Dhq8+S/Ggb50296hL2Ew8OPW1ke3MKGsmaYG
	 94FE9tYaSs793OJ0h0F9o6QkJq6JVZI3LkWomBK4649kne5iynOtzPpd6fEfyi+XhmH3D
	 JMT6H/XMIWFP9Dt7C/bZu4fQenZvo8vWfAhUwXtKcoSCaBFfo8GT/10AScxJWW7WFiJlA
	 AYQzvIeJXm3jmk/4ncv0p/aIKfQBqZYaJdALv3IX9A8Wmqtu7QqIOh3ei4ebww1VgkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793256321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=PpZwiOLy+qBSQ8PQ3tlsCfW6m/0pXMByVlZ/42AmEx0=;
	b=KRuIX91T16SCZDKoUJd7OHpzX2tBYTBjIvcPm6dWKPUbp5FcOyXcOHf6cORSHaBKybSH
	 CtM+QmuiweEIivJKkWoPILRNJrdNR/Y7/uuBitjjCbg6ofSYy/Jog6aZeBj1XwEZjrpKi
	 Riio8LKh/+/u00hLHXNppqXs0xGQV5Tj87Gz/5FWWrpHTlKoVsJYUTcKU1fea/byMEM8B
	 2kNOzf+77fpBXtnIkpeOBXJwEdOeMc1WQzSLi2+2JY7Ul7t1+EgExDeu6PYinfLXnABQM
	 NctPUsqB8jmkvU1Fmj7Mfar4cO7TXysLzeNcplKqXVJkOKjoAVL3oR3PN8w5NBhv5rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="KCg5n/Q8";
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C989606A31F
	for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 06:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C989606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KCg5n/Q8
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ea759cc9b6so7369085ad.3
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 23:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793256320; x=1793861120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PpZwiOLy+qBSQ8PQ3tlsCfW6m/0pXMByVlZ/42AmEx0=;
        b=KCg5n/Q8XqL00OlgFFq3nv6XZvSJbvibwOIUf3l4ieuhRJh02MJd3TmHNL8ItAvBb6
         DQI7zORWyFVVog+kbdHN/hAjpeFznKr71mR13ljhlNkwi/XxIpA2gM2IQ7y8YAQ+0G3H
         ji7h8gpO2SHejHiHeGkBF7sakQPW7l1YdGaqRXkXMFRuxljqORyfWpIq0YHu7SCZ6iVS
         kye+V+d3VcqR+mnKfGJi3n6/Q4Yd+xqIXxBtOLaP8gROLPokcoy9TYDEdztFWQUwCpQ5
         bETn4zmz0nsCFsoruMBK6xUnzv+Hfawie6E/LuJYrcqEEaNK3MZ0HvwhMP7lgfZhK9T0
         kgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793256320; x=1793861120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PpZwiOLy+qBSQ8PQ3tlsCfW6m/0pXMByVlZ/42AmEx0=;
        b=re90s++1qYY/yYxyBy+WjK9p7LOHJ+6Jk+wheUwthpqZBPyyIX0t4Vh2m8EdCjGyZM
         LnaHHPrum+Ht2dNrouxW4rgfbPcv4t+TAJ73I5yGpxZ+XyopUeALd3uALQMIPdFIbPeL
         kKxp4mef6kItUSHs0k6TA30C5WGRLApN8S3935ytyx7D6KoBWHHr3bIlvHISzjBQT56V
         k8EZycdndVXLhNRR95BxH2BSTEbZzf6G4dr7AuVxA4vYieDN8okBaSu3J17a0Pj6/9KK
         ro4gSaVT7uoEINR/8FgX9nCdSOFQmWItEy2r2iMQYWSrsYPkfQA4sE/chjYWNDwJwf6+
         2psQ==
X-Forwarded-Encrypted: i=1; AKwUvBxnriLruAzx1Gg6sRAbRv8TeR3eMOTLio+L9VUZqzf8JKEmkELrHRqmViCvAwlkoQA4ZXKJWwQUy4s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKiioDP92mGH0aLHWNmoFIf2TffQwtKlpcBWnmDaSWWte4YUgE
	WuIqN47xCtJdqIQt9ePH27lCm+CkE4iCNtso8eZohZdG7UHXCmGMN1H4
X-Gm-Gg: AYBFou1noWgqqZwXVLbPKkgCLmyKdxu55eKFPd76Ur+fg03rm7pm3I+l4qKBxcqgVt5
	CVRNGM/Yljs0/KVQ8A+HFh0T5Hw3upa3noxSANMubUw98gWR7zK44IqsleC8hnJZmUIrApLk0Dm
	cydDIC1YNFAT/yaxNR/JBr50wbpBuf+0oCc3yDHy+CX24nZQHhtHXfaF+RJrx0XO7LTuLJcFGSq
	iZJtAUQnsfh9EYt/hZhuCQkxJ7xTKBaBJOCbjXMjiL8xgnSzyClyCgjxVeAPiUQ+2fuJAQlX1BT
	ZGglefCDrUN4vDA+22WO2v6vSgG+1IHxu3/N4oIkej4RN5nWcjJE4LrF2P4dMEDBgUfohxCAWvB
	j3voZumVdJ/8v/CWhTKuMMLhqoqu6Co5mdcK07JG0k4Iga0oBu05M5H3oSoyXAoKeidnjLVHGUm
	SWqOOrpCmOZdQpHb1izT0UjgBWvGAuQJwq/25DhIPe9cjk3zpwiO32qko6srhugu1IU9tUk+5qn
	ZvW6XoGcBiacmoajTfHYUvwUpCsGAs03j4rHPg6qxNiquvNdd13sTipR4iibfsL5tDY3gcnk1nO
	9LKvsdjSohmLTUxJCeqK0LDqhkkjOBGuJq6K3QViShiq7cOZoQyjxQ==
X-Received: by 2002:a17:90b:2543:b0:3a0:e1f7:9b04 with SMTP id 98e67ed59e1d1-3ae58172e4emr3338233a91.12.1793256320522;
        Wed, 28 Oct 2026 23:45:20 -0700 (PDT)
Received: from localhost.localdomain ([101.44.96.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8401casm2729502a91.11.2026.10.28.23.45.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 23:45:20 -0700 (PDT)
Sender: Yilei Zheng <trilithzheng@gmail.com>
From: Yilei Zheng <trilith.zheng@gmail.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <djbw@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Mike Rapoport <rppt@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 3/4] mm: add shared read-only vmemmap support for FS-DAX
Date: Thu, 29 Oct 2026 14:45:10 +0800
Message-Id: <20261029064510.17667-1-trilith.zheng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <2E5C10CF-F3E0-4694-965C-B0E432A1A962@linux.dev>
References: <20260903122128.12264-1-songmuchun@bytedance.com> <20260903122128.12264-4-songmuchun@bytedance.com> <20261027065723.66564-1-trilith.zheng@gmail.com> <4c9741cf-ac62-41d4-9c7a-7d5ceea4a8e1@linux.dev> <20261029030511.12004-1-trilith.zheng@gmail.com> <2E5C10CF-F3E0-4694-965C-B0E432A1A962@linux.dev>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> What's the size of the roots image? And I just want to know how much
> memory this series could save in your workload.

In our setup, the rootfs is an EROFS image exported from the OCI
container image, so the pmem device size follows the image size.

Most of our workloads are simple today, with images around 1 to 2 GiB,
which means 16 to 32 MiB of vmemmap overhead per guest. And we expect
the average image size to reach about 5 GiB as we add heavier desktop
and agentic RL environments. That would save roughly 80 MiB per guest.

At our target density of about 200 sandboxes per node, this adds up
to around 16 GiB of guest RAM saved per node. Memory is what caps
density here, so this saving helps a lot.
