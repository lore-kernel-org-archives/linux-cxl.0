Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295AA226D10
	for <linux-cxl@vger.kernel.org>; Tue,  3 Jun 2025 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985403; cv=none; b=FdsVekmBVbqCxbUQkST+1oI38kebH7NAfJPhBwo1uN69tWDWEfYmxUEJhEyVz+e4eY9oFWQLAGhm3YeyJLnHScPXnMmJBjGGKacnqLMqGDvtDM6OJ+nvlRWdknWLlyJPiXPc3hovGR5yr998HF6K8SxPJe7TgUHJKlKI0/d2tEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985403; c=relaxed/simple;
	bh=XoGH0h2IJWjwbQWxYS/rtN7yH92g+3vhD4JjuLqqPnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=u1Ka6GVs5ZNgGYv342Qc/fiPVp6Z0GRU3d4zb/e3REaIFQebe5y3SYoHaySXihwV0Mby1osa9m0tETR1ME9E+AKqMCTWbSdwC12x+P/z/WK+nJEVT1BGFTYI0TSV5udEJ410Kb6kTUZUFfvCP9kscnqxeC/2YCdOFRrDNL+o5yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hyClcddk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyClcddk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748985401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=314MrEBwr4k+CUpKTmx4sCu/ScFWOUTeM6rdnwbV6hM=;
	b=hyClcddkVtGzi6PSC4yUzM3n9yn0Ey/DkNK/KEhmlNRUPMX/e+HabHHj2e45v2k2czAzhR
	kQApH0smjztfJ3OB1NAsMg6TFwC5kfwPqwRo2aR9e90IGuXER5MVRIDgacNYAkZqjqefUw
	EvG1JS6Og+k/Z4viAsWUM/2T5QMmzdk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-CVHlkzOmOzScvo0RsuW8qQ-1; Tue, 03 Jun 2025 17:16:38 -0400
X-MC-Unique: CVHlkzOmOzScvo0RsuW8qQ-1
X-Mimecast-MFC-AGG-ID: CVHlkzOmOzScvo0RsuW8qQ_1748985397
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f6cc5332so3198076f8f.2
        for <linux-cxl@vger.kernel.org>; Tue, 03 Jun 2025 14:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748985397; x=1749590197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=314MrEBwr4k+CUpKTmx4sCu/ScFWOUTeM6rdnwbV6hM=;
        b=kn8a5sN5dj2SvNRdAYbd05/t7z18/EWJAli3QTm2MCjiaz/E3pJrvvApJRmGXv2Czd
         9tMJYK7fNX8MebUszLCuBfo1HKJ9qUPziP5C8havAjWqQFn42xkGTrIaADXpYSfwxDzc
         lVEpqgohEnTRSegNCsqR+O7Mrkq87/NdQAaHOcXJGXHdP2FWig7OrAnDDT2fsiog1nkF
         643+DzTiqpt1URTEWMyBcIWqTDDH1eJfpibjXtOMY7xFPpLhovBalQPlwTKo0X3XvZAp
         RC1sgzLTXUzTfhtgEqVOWMMohmHGJWwcQj4racFLOD2ofiLP4sPvehD/bjEaW9xoej+s
         XBKw==
X-Forwarded-Encrypted: i=1; AJvYcCUOi3pJSaTq3KhZ2JpDpBOKlFy/iuiAmRKJibeINjELJUyJk8qh5pYiIUPKmIN2sB4UwD6FvqrOocM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTTG+MiNAg85cY5ZyFsQnjvfVsS3e7ov+EPokfIEoI5t31aZjp
	vjV93f5w0bjIkdQRhV7q4qoQFtWNwAyAMeaCw6ln/R0kV2yQpy560U2+3ec5WVoGT5qcM9ogdCC
	kjWym12ds/3RX+JEX+8s1APTG0cHvHvD+3FTofPw+zNUqkA8Xf3mpETsWli2tqQ==
X-Gm-Gg: ASbGncspLz8YSnP1/CBn5+s3oMrLbeqvJlSNIjUy9NR64vDtBiq/fspbEyu/LWlKUO0
	5jYUyQrDNXXCGGc10N2cCin1xpbdqpseXI2ZA4G6/+xWWXM9bI9TylahxtxD6jtjX0K1fo6Cr8M
	X+a9imBMJ3VK7WZXQqR9lOiktVE6imesOUUoW8HUpPjLNpTVeqs9lH4DztsuDcDle+o9agsDne+
	qcHWROe7ET5Bt6doFZyOB2nj7qScC2kPu4FBbDxFYbiCT7xOBjFbka/0j5e5OQWNpv3S/CHZbQo
	baoCUrj9gg/8tAinebAN+3DDM/zTOnkpIesWlbirt2bTeS7BqpnzVURhcxIMpWnfLQArhT6R
X-Received: by 2002:a05:6000:1a8a:b0:3a4:f379:65c4 with SMTP id ffacd0b85a97d-3a51d96b480mr197080f8f.45.1748985397095;
        Tue, 03 Jun 2025 14:16:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8kkzJnQJD0YMtEENpld5wUwUCJ3Dmqv/cCnKp6Z6c5loiuHX+OBpCRrySLipJK13BBXeN7A==
X-Received: by 2002:a05:6000:1a8a:b0:3a4:f379:65c4 with SMTP id ffacd0b85a97d-3a51d96b480mr197074f8f.45.1748985396684;
        Tue, 03 Jun 2025 14:16:36 -0700 (PDT)
Received: from localhost (p200300d82f0df000eec92b8d4913f32a.dip0.t-ipconnect.de. [2003:d8:2f0d:f000:eec9:2b8d:4913:f32a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a4f009fd7csm19308738f8f.88.2025.06.03.14.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 14:16:36 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v1 0/2] mm/huge_memory: don't mark refcounted pages special in vmf_insert_folio_*()
Date: Tue,  3 Jun 2025 23:16:32 +0200
Message-ID: <20250603211634.2925015-1-david@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 96AJGPuSE6fMDFcSH0ccL7f4E_5l5bHt53iynsmMsVw_1748985397
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Based on Linus' master.

While working on improving vm_normal_page() and friends, I stumbled
over this issues: refcounted "normal" pages must not be marked
using pmd_special() / pud_special().

Fortunately, so far there doesn't seem to be serious damage.

This is only compile-tested so far. Still looking for an easy way to test
PMD/PUD mappings with DAX. Any tests I can easily run?

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Dan Williams <dan.j.williams@intel.com>

David Hildenbrand (2):
  mm/huge_memory: don't mark refcounted pages special in
    vmf_insert_folio_pmd()
  mm/huge_memory: don't mark refcounted pages special in
    vmf_insert_folio_pud()

 include/linux/mm.h | 15 ++++++++++
 mm/huge_memory.c   | 72 +++++++++++++++++++++++++++++++++++-----------
 2 files changed, 70 insertions(+), 17 deletions(-)


base-commit: a9dfb7db96f7bc1f30feae673aab7fdbfbc94e9c
-- 
2.49.0

