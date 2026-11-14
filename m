Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794642613;
	b=NWj2n02074VYst4ifdKdgrC2LbRygqfMfgbOXYT4l43wVcK8i7/W7KWoxfglfqlsClty
	 vIcjSQG7d/Y7W1BEv1IJ3/creTF4LhoG5cWy50Ky6lY+n1V1nmmo5ncf3asNPGjJKLLjN
	 tzfAiJmZKUWArauD9rLeqKZDTbJT4/I/X7+q4WEVZKFMmU+3FZvvLJ25OxjgCqKcgiOpE
	 qEyR+RvkFlxxcZ5WJbjoTNSaTOKCP7k0/5hKEKBGJePIXcbj4OJNSGTfjdj/Yv2xaUCsX
	 kQ6NROCmY0eZe/mpRJSsfoUGT4tXasUYEQJ6770Wa66PzPhOj0jVZ5m5/WPTqC3d1Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794642613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=cGbHDC4e4qa3gSIc5H3tZOXqH9VLSX3BMg1aP/6Q428=;
	b=S35RJ9dykz++f+ys5BfuzQdDlqJXYAMzDtNv/lWcUNR3pxNKbb3lLTHQDmyZUvI/0X1B
	 jZ/8nDAm/dI1EEnI/UKTO6RSBZ3ajlXkFqO+OOe5gFk1a8f7W29tJKb1II3SYL8bmJwZq
	 hDedGdjBg+AwE5INIIzY6uHe9JNxunFG4Wmf5bZi5F2Ptcwb/KwNcjVG9b2Dg0cqOokD2
	 5jKlXaJ2N4R8jyLAEGV936jD22sM6Zx/vWNC7tjeVb/7dxR+4g9UXZvmbE2fwWwyjKxqQ
	 /SrLAs2f6rEqenO1lRKxPAvtTELiYOKpzdgov8+WNuFs5Cf5ZsZinDDNksIn25uLErg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=SF6em5du;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6338606A323
	for <linux-cxl@vger.kernel.org>; Sat, 14 Nov 2026 07:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6338606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=SF6em5du
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5361e313e63so31610341cf.3
        for <linux-cxl@vger.kernel.org>; Fri, 13 Nov 2026 23:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794642612; x=1795247412; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cGbHDC4e4qa3gSIc5H3tZOXqH9VLSX3BMg1aP/6Q428=;
        b=SF6em5duzVjUCkIvgA+5+oFXUOsWIns/6/N7iMwfWnVzbC1tBgVSGZ0POCCGPJGAph
         lZzuvdfVtGLtNvnnMk4Q6fmeQeI1Zf4z1y1Np+gv3FVtwN/PdMlHceEufLPJUXVWuW3R
         yT8zxaqtXQ0KIt/xqddZ5oSC2mDPTlWBYMdjFbhLdc3MenvnJvjogSPz7V1igH0WKT5G
         YLOqL7cBD3Ed3rSLgTLWmXdhYqfhKZJrAesyFiW/4xR+1Li3Obfdw3cVrzn0wC3ppXcZ
         CvQxB8JFCIeWSx7dJwgOT9LlaMqQglsw+XA8pRJcYp/5jbGZ2FKUHHmKR+G/C5zqp2Lx
         YQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794642612; x=1795247412;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGbHDC4e4qa3gSIc5H3tZOXqH9VLSX3BMg1aP/6Q428=;
        b=tIa04R0rJhIGmhq2dl+l4OyrG638eDnYGnWnWAuosYQIF8UWOtJTIIgFcX3nzspS5I
         Q+A4gjqrPCdSDEU9rerD5PcW5gGuOipKrw888TVAxus6teJnXzyrHGl4nlPepOe14Dql
         SQY/5vrvdpsY3Ezj0Cr43lZVDzsQVEEbN1KEjTyMbiN3YmqZgKR5yelSukft4L4ay+S7
         3ensf19dfV3rz14crlSVX3YukpsMWV321SdCgNWMwSahLyvN0h+mjRbcoptC2g3L5dBg
         nvRHbK8eChlaBTHOEuElNCrClJNGcn6IyZDb0ZxejS77IXH+YyU8/Rj6aMfJb63AE2Ux
         PAaQ==
X-Forwarded-Encrypted: i=1; AL+hErEIBB+XkynxNnZOYiMBNJYU9ZiLr81VAUnYciUeg/SD86pMNyVwl1/7fSzCRRtnOPwbzHtW6gVacyc=@vger.kernel.org
X-Gm-Message-State: APuU4Z91uoMvzaXCBU9DgwjoJy1FQ1FhzqV/n0EomhiyqHHS77Iop9Zp
	m7fJVzYeCLXoe9qoLZ8/jQCSjNNUtOFqCpm+WWF3UAzpaOPMj96LHJg5ohBQ6J71u7g=
X-Gm-Gg: AYBFou3KZtrzxihutOKENkRyMJFA9eAATufiNYQif64bEAMz7KrQZBQ0+QwkwL0wiKY
	uJD3jWiyamIIosgQ5fRbixoNRadxlUoiqxA3fMWkBp7nG1XlxBZ214giJzaVCBHqc9olVbcXFlv
	RACxzuKJ6G8ssmr0Hbkw1D6PPTGk+ovYGctY29lSktkP186EsmU3ntGRY8UbgiuSZ8CbJOH/Fjv
	1ei5+rRfRT8n7u/T/alrfTLWAdkhNyk2DiqEIIy/+xFFRMglxutIwxoVnUek8dec0tkkH8nr4TU
	eiw9BwvNG3jJYET5f0vq+GySZ+4torwH5/tU+5Ifb0ZdiQ6KD6QAfpRnsBgoxqH+kcVrNODmeOc
	p8ev2NxfdzS39EhzHgMEUycuhFOjajLh/cuRvlcp46st6l6NLnEmCeB6Q4QgeHD/Mve3XIkq9tt
	Ze+mQGozZglghiOyRo8ctVZf29HSH99U1AHn6ExunuHrctzAl8a5Z3S1UgZGU6eNKObcYF39H9U
	u8v+0QweUHFPcJYluNCy7UkprUdGNEq/Q/Ccg2idKf/LxqWowU2xT3lr85mSharK1BIAnkYjhsP
	SXGh231xCvihTGwIhmb09lIwUUJSP84nivIaC+Q6TOWdWkfx498C5QP6qkIig0ru9LTphwtvefJ
	4foILyEI=
X-Received: by 2002:a05:622a:4890:b0:536:6378:c80d with SMTP id d75a77b69052e-55ac7d4f0e5mr76447071cf.32.1794642611571;
        Fri, 13 Nov 2026 23:50:11 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d445d1sm38109806d6.8.2026.11.13.23.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:50:11 -0800 (PST)
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
Subject: Re: [PATCH 20/22] PM: hibernate: size the image from common memory
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: sashiko-reviews@lists.linux.dev
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 kernel-team@meta.com, linux-serial@vger.kernel.org, damon@lists.linux.dev, 
 linux-cxl@vger.kernel.org, akpm@linux-foundation.org, david@kernel.org, 
 liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
 mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org, 
 rdunlap@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org, 
 dakr@kernel.org, johan@kernel.org, jirislaby@kernel.org, kasong@tencent.com, 
 qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
 baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, yury.norov@gmail.com, 
 linux@rasmusvillemoes.dk, pavel@kernel.org, lenb@kernel.org, 
 hannes@cmpxchg.org, brendan.jackman@linux.dev, ziy@nvidia.com, 
 sj@kernel.org, muchun.song@linux.dev, osalvador@suse.de, 
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
 lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, 
 xu.xin@linux.dev, chengming.zhou@linux.dev, joshua.hahnjy@gmail.com, 
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, matthew.brost@intel.com, 
 byungchul@sk.com, apopple@nvidia.com, rientjes@google.com
In-Reply-To: <sashiko-outbox-214264@kernel.org>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-21-gourry@gourry.net>
 <sashiko-outbox-214264@kernel.org>
Date: Sat, 14 Nov 2026 02:50:09 -0500
Message-Id: <179464260972.482102.15351839494267219366.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-14 07:34 +0000, sashiko-bot@kernel.org wrote:
> > @@ -2011,9 +2013,10 @@ static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
> >  	struct zone *zone;
> >  	unsigned int free = alloc_normal;
> >  
> > -	for_each_populated_zone(zone)
> > +	for_each_populated_zone_state(zone, N_MEMORY_COMMON) {
> >  		if (!is_highmem(zone))
> >  			free += zone_page_state(zone, NR_FREE_PAGES);
> > +	}
> >  
> >  	nr_pages += count_pages_for_highmem(nr_highmem);
> >  	pr_debug("Normal pages needed: %u + %u, available pages: %u\n",
> 
> [Severity: Medium]
> Should count_free_highmem_pages() also iterate over N_MEMORY_COMMON zones?
> 
> On CONFIG_HIGHMEM systems, enough_free_mem() calls count_pages_for_highmem(),
> which calls count_free_highmem_pages():
> 
> kernel/power/snapshot.c:count_free_highmem_pages() {
> 	struct zone *zone;
> 	unsigned int cnt = 0;
> 
> 	for_each_populated_zone(zone)
> 		if (is_highmem(zone))
> 			cnt += zone_page_state(zone, NR_FREE_PAGES);
> 
> 	return cnt;
> }
> 
> Because count_free_highmem_pages() still sums all populated zones,
> enough_free_mem() continues to count free highmem pages on non-common nodes as
> available room for the image, undercounting the normal pages needed to back
> highmem copies.
> 
> In addition, alloc_highmem_pages() and prepare_highmem_image() use
> count_free_highmem_pages() to bound loops that call alloc_image_page() or
> alloc_page() with __GFP_HIGHMEM and pass the returned page directly to
> page_to_pfn() or swsusp_page_is_free() without a NULL check, which can
> dereference NULL when highmem on N_MEMORY_COMMON nodes is exhausted while
> non-common nodes still have free highmem pages.
> 

HIGHMEM can't exist on a private node.  Private nodes require NUMA which
require 64-bit.  As far as I know HIGHMEM is 32-bit only.

Trivial to update though, so for consistency i can add it. 

-- 

--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1291,16 +1291,17 @@ static void mark_free_pages(struct zone *zone)
 /**
  * count_free_highmem_pages - Compute the total number of free highmem pages.
  *
- * The returned number is system-wide.
+ * Only common memory counts, since image pages come from common memory.
  */
 static unsigned int count_free_highmem_pages(void)
 {
        struct zone *zone;
        unsigned int cnt = 0;

-       for_each_populated_zone(zone)
+       for_each_populated_zone_state(zone, N_MEMORY_COMMON) {
                if (is_highmem(zone))
                        cnt += zone_page_state(zone, NR_FREE_PAGES);
+       }

        return cnt;
 }
