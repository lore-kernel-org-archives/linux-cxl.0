Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF1D343D7F
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 23:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782775809; cv=none; b=UHpcXbZGBznMO2naxkcGKuqt4KztuvIFwFLu5iv1bZW6lrNlAl7WjFYx0ZvvZKhwCEVBqTf+c5e0CulWZhGaDDa2wrc/OA7ic9Ua8oKRslRuC/9Bmx0pwLwAzzet8YnzUfFZJHvaM20uNjdarTbkGM8OsBGXuGMw1rgP1XWychA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782775809; c=relaxed/simple;
	bh=sokzlwolTexFv1vDXEc+j957MqndM17jhKFQ0pYjr0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eY6zG9MB4rwkQLKSQ/VHWhEkcAMlv6pxP30yO4+QyNtHCKG5HyG6U+XdX5ltPRKXy5rV8816J9ayCVaL9LWIicY6z55GAI5juxcOByMutvaGABJED8GOena/ppxiX634bYnJ3lWfKULHtSkkDcOLA7OGX+v+llUOg4u+//Z1/tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cQAkxPQ0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQAkxPQ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782775806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bOB2A3Nx/t4sRU/lLAvGFLJpztA8K98QuH51mbtmEIk=;
	b=cQAkxPQ0wFUZkuUpa8t7xsaUf8YYiGyG7IXK8fo2Wn2jwJclpMTfoCJI30qAHWKGwFfbBj
	B0t0LJ143PMydRAtdpmod7SdNDbgOST88RIMoYswcGJY8ndCo3R0sBj/3R7yZCUsvnw3mO
	QFR5VRMY5qBwLV7g8kGOaLqrfbGl/ow=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-sXqVy8RcO62tiBF0t3-9fA-1; Mon, 29 Jun 2026 19:30:05 -0400
X-MC-Unique: sXqVy8RcO62tiBF0t3-9fA-1
X-Mimecast-MFC-AGG-ID: sXqVy8RcO62tiBF0t3-9fA_1782775804
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490c56e2576so26293305e9.3
        for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 16:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782775804; x=1783380604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOB2A3Nx/t4sRU/lLAvGFLJpztA8K98QuH51mbtmEIk=;
        b=a/Ehm+sKC3f98vAd7eMvNZDvIW1voRMSoLAHVBFbyEFcjm/V/cyp2sS6Em7BjlG1OL
         ZgfJpKgBMTu8MsbrNal9nBHPMU19baL26ArJmzKLLBrrTMlp0XWonBz1JgnY20Sgxons
         WxefnxmAOd2Mal+IQqQ080ToVnQ+PEd+Os+T6ICDqmUMXAbl78BFdTMjKvwZCN2aLNAa
         gINXoFyO8oMHdLqc7AJL4TVByRsLQ6sJ8ZLBbWigkY66vS5L/mLoPlnIJdD4HQAFfpdI
         QdylYVZnn6uNsQT3ZiZZshauVH8F+4s86D6GZBWnPxwGcqQC8zLeY12CK3LAoy1+ZhJc
         rahw==
X-Forwarded-Encrypted: i=1; AFNElJ8UIKO1fbPl92It0VnbJuFI9yHagk8/+2KkNaY1qMsB6jDp9ddPioFDnKbJVBo+DHaILr64dH7mWtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUfwfj92b71yhecq2+brNCa4mEXRd+0MwObG9QHIhiKj3IhC3u
	SSSm39ZPiG1bWg2T5uAHkbt+eDLOuwn6lrE4+TqhqX0zYZhCLGtmufMijXe+wMqW254/MVwOT9M
	J4osORasdngk10yw5jQtRKmw/CHaJHMaDh5rYRGo28VXtgqS2EFuQ5EDONtR0Lw==
X-Gm-Gg: AfdE7cn0vFAErtGkgvvFMDX2AOSipXIX2l/9Bq0OBhZx+oooU2ijhaGvlmvrhciJHyi
	S52+tUKqR3Bh16dbPCYHx9FvAUyMFVN95I6shHXE8xiZbKfcFYnnRqpitFAuJFYgoX4OLBfZbGK
	ua8815HebWsfRhBlMb0psOsen5yOcApdc4tCHVLrtHESiH3gwszTBHBDB9KSCt3poyY4c2OXA61
	9ma/mn/cZf/kXOP+DEO4hcGK0tu8eov0BPmbbRqg+cHZKfmvXT0iJwl7bSBBk9hEtgmq6HMCs/G
	bgiF3bjjnSN8E0zTdSYQdmojLsdMejNFgIgF0JmV1nb30xxghbOKsXdycs5dKxCbmoqOa3KlNTj
	OAAZIdj9/zwrOmteC+iglWbG8qu475nJi
X-Received: by 2002:a05:600c:4694:b0:493:a8eb:5145 with SMTP id 5b1f17b1804b1-493b827e9ecmr25267245e9.4.1782775804088;
        Mon, 29 Jun 2026 16:30:04 -0700 (PDT)
X-Received: by 2002:a05:600c:4694:b0:493:a8eb:5145 with SMTP id 5b1f17b1804b1-493b827e9ecmr25266515e9.4.1782775803560;
        Mon, 29 Jun 2026 16:30:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d195a7sm2001293f8f.7.2026.06.29.16.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 16:30:02 -0700 (PDT)
Date: Mon, 29 Jun 2026 19:29:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andi Kleen <andi@firstfloor.org>,
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
	Rik van Riel <riel@redhat.com>, Vlastimil Babka <vbabka@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>, Byungchul Park <byungchul@sk.com>,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: memory-failure: fix HWPoison flag race with
 non-atomic page flag ops
Message-ID: <20260629192811-mutt-send-email-mst@kernel.org>
References: <cover.1782676497.git.mst@redhat.com>
 <0b5f8b4b-d7dc-4b79-9555-a5b36265f3a9@kernel.org>
 <20260629030657-mutt-send-email-mst@kernel.org>
 <4f5ba5d6-246c-4430-9737-e8dd8e4c5142@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4f5ba5d6-246c-4430-9737-e8dd8e4c5142@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8G8cQolDiJ2AW-n2jzLLXEt1g_fS7ga9YA_0fJmkAro_1782775804
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2026 at 03:05:18PM +0200, David Hildenbrand (Arm) wrote:
> It would be good to coordinate here.

Case in point, do you feel this should be blocking the zeroing/page
reporting work (which adds more non atomic RMWs), or I can work more on
that putting this aside?

-- 
MST

