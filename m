Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201147;
	b=AZw7V5+vlDzSBntp9II76kqZO0hbMOZ/G7EE41YmT5b2qAH0RIkdBB6iIJ5ZTYCTBz0H
	 HkFlpsDYVwxTjGx/jhuBoGTCwRnO8v0qrb+T5TNSTxJ5c2PMTE1XfhoRR7b+yAY2f4NjY
	 N7YY8f4Ca5TJx6E2O0ZXyXQjGfo0G6ksrDPxEfTkFrgoZ5FU6nwHd2fo9chRd1ohHtq/Z
	 0/mBBFyTfzYaAi518sbVDwx17wIp7sCsIjpwFlOzstHDwo0wJ7K+3pOOrF+gqVYsHNcgj
	 0O+bFGjAQYJBm33Qd4wZFKEjNtJMsoDvyGV/22Kd4xJkvhUaorngfxK50OWpH+4Pz5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=QpjWV7nVPK4jNL88HvKbtHJ/44FkOvQPFo/KHrxl1Aw=;
	b=YIHr/e7BZXHGwYD96YBm1BNXwQhh+cgnv06gOfnfGLknxe1fNZCRn7TlJsxJ7pjQQbas
	 AmGizSwkP75WdIpSQsEwvvlu148Ba95/Wzd5HWkSwzUfkr/vUDO1rDKN5c3MrjQ4m6HP2
	 5b0TBw2gd8MmIwQOZgmT79VSI2eVjLB2u4+1fwyjtwFBTCWk3Lf+SiBnSO+r3td0WF8fY
	 zHK21syTxxlyRg/vUMRJQbAn7VaR84oaYqTwm4iptv0Zrir4vdjT4F4Ino/a5BScW8PN3
	 W1tLUOFp6S9+7lAndh8IK/wTZA/VBbNkWAFERr7S2u9sV+a2nP2+rFmbaI49quVGDyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=jP9mDgSk;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B845660A2606
	for <linux-cxl@vger.kernel.org>; Fri, 20 Nov 2026 18:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B845660A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=jP9mDgSk
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53644b28706so19849551cf.3
        for <linux-cxl@vger.kernel.org>; Fri, 20 Nov 2026 10:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795201146; x=1795805946; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QpjWV7nVPK4jNL88HvKbtHJ/44FkOvQPFo/KHrxl1Aw=;
        b=jP9mDgSkXq83tjLxbrSbvJK4VhOzYkMGnT1Jm7gDQe/tOWOQWw88VffPoBHzpHtdXZ
         AtKDL72AvMbm6K8+SFolZTdZsq5YCre7TYo+p4r5NsYo5qfix5Rkg5grOkKDHVKVNOAS
         7oCG+E2fpkpUAmmLwq+0Xp2+UXqhc1fXlcHYaL5btJezkYRzJilsdIXdINfLoFlm9DO8
         6CbBfgZVvOJVM+JRwdAK0Dvz71rzy7UBvr/rr8US3Cw4d/p7KopxcO/pFRWbieVCQcWx
         SzmzqLmCMHfM5PgM23TucdXta6FY4M5TN5xDVyML6rCM56A5+RYnYnryKZHICDqx3uzd
         4qmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201146; x=1795805946;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QpjWV7nVPK4jNL88HvKbtHJ/44FkOvQPFo/KHrxl1Aw=;
        b=yFI2GheUdBdHmN7q6iRBWkozM3wTY/nzro+PQhA4cKa7XlULQ3VQCl40e7XH6S0VZv
         JQstPdXUOhB9gTU+pDrPq/IZ60dXqKJYkkBbfXtHKslnq5s8TJGmTbSsVS4smP3eH5FE
         KxGkW5pVpZUxf6Nc2IEZM8RuHQyOwW1b+mCwJku2hyVycx85UzIC2sQIfFSjGqfmSMZN
         /37MpgKvix/2x0b9lDzatcMdkQrv2D+xg/W4jwU/rbUI8tbLw/WilfLtcHX7byJx3gHX
         a/4iXBHkolVXcYGbxKt6j6Bojq8I2rPcUtyqxKRJfBLQDnmcErshE+ikqKWONr+GD6ej
         VkTA==
X-Forwarded-Encrypted: i=1; AL+hErG6JZ9xowSqJtpQhx2mI0mG5mQhXOtJbLDdOHcpWtFWh2Tyl3kU17/RyZd9WzSqa+7vtP9ApfBBRzA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7kuH3bgQJsPeb2y2EcasJHDwb9B6Lwyln+OyoyXAOgR3lArjW
	XhNY0uaGvMwHN+bsSWjhtpUW8siziSVkGBVIIiBDeWyQyCz+zCCp7RLjD0xAo8m/2c0=
X-Gm-Gg: AYBFou2KD2l7/D6Pag2J+FdlMwtVbKDw51VIoX221/TqU01tISkpUVZ9ASnoXBo8Pbq
	IGJUYYS9jnGI9L5FSBHqdxopO4utyi3LVc7w+IVavoAMz2c8FFVp5+y8eHTF7899ISl2y3NzZaw
	xBzt63SF1GogNh79pZnILEbzd6i7RYJIjKjxmwQrO0qmgF1c0t0KBCjvZlXnPtpPLz2Mk9SdWwn
	Yxzu8IOAOvOl+J+d+ZocCF0eNZsHKC490iEMKoLPiQ/Jdc3gfnuS/tTZzJqL184lEGKBh0NRN7q
	NrJWypDfdYhNbjMaA0S19wMFcIVDwY32E5xWNI0E+LuodtMY8pu9OsXlHfwhiu8Sudbc0xDXn80
	sGhobp2sZnbJ8CgSSvqywnXMovok7ht6AfRzBJ0UNlnhfUsBmL0tzIUcHtQMbk4GmaCpP5+z0Dt
	b5zfpiGpGA752CWEbc63ln7Opl6dPYMGRXASz+BWp8bFRZEKwZf80r7CtSj0RamfesULUb/7XN9
	rwp0qLJsfgqe1hPwkfWkJmKp8Lq4jMRysGP/K85v8IwYy0J/2vypyXFjThcSM+UsUnvZha7ZBUw
	q400eA6Ks089umptnYhnd5F83nQVq5xO4l4J0LPhrNNVJLQ5AhI4HyRCFwkwcGSDnua+mNGlHtU
	I8lsVoeY=
X-Received: by 2002:a05:622a:1a89:b0:55d:2c9a:3776 with SMTP id d75a77b69052e-55d76a811c8mr74428711cf.65.1795201145651;
        Fri, 20 Nov 2026 10:59:05 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7884d01csm30305771cf.21.2026.11.20.10.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:59:05 -0800 (PST)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 00/60] Private NUMA nodes
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Oscar Salvador <osalvador@suse.de>, Johannes Weiner <hannes@cmpxchg.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>, 
 Alistair Popple <apopple@nvidia.com>, SJ Park <sj@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Michal Hocko <mhocko@kernel.org>, David Rientjes <rientjes@google.com>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 Jann Horn <jannh@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Youngjun Park <youngjun.park@lge.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Waiman Long <longman@redhat.com>, Ridong Chen <ridong.chen@linux.dev>, 
 Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 driver-core@lists.linux.dev, damon@lists.linux.dev, 
 linux-pm@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 cgroups@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
Date: Fri, 20 Nov 2026 13:59:03 -0500
Message-Id: <179520114342.412063.6068641130948664600.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-20 13:08 -0500, Gregory Price (Meta) wrote:
> This is v6 of the Private NUMA node series. The series falls into four
> parts, each building on the one before:
> 
>    1-18  mm: introduce N_MEMORY_COMMON
>   19-26  restrict folio-walking MM services to common memory
>   27-44  N_MEMORY_PRIVATE, kept out of cpusets, mempolicy, accounting
>          and the page allocator's ordinary paths
>   45-61  private node features, memory hotplug of private memory,
>          dax/kmem private mode, selftests and documentation
> 
> Patches 1-26 change no behavior on any system and can be reviewed and
> merged on their own. Without private nodes, every path in patches 27-61
> behaves as before.
> 
> The full stack is also available at:
> https://github.com/gourryinverse/linux/tree/scratch/gourry/managed_nodes/private_nodes_v6
>

Apologies - my b4 prep dropped a commit from the stack because I made
the mistake of filtering on author (myself) and it stripped out this
commit:

https://lore.kernel.org/linux-mm/20260923211041.3127588-4-gourry@gourry.net/

The commit is one the branch listed above, and should be otherwise
indepedent of the series (can be pulled in ahead of everything else).

Sorry for the noise / compilation error, won't happen again.

-- 
~Gregory

