Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5553D3012;
	Thu,  9 Jul 2026 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579318; cv=none; b=uaubEX1T+93trfKwNnSQei72MhkQBS9dq00I32SO4qJ864nuthF5H9qEyC8YwTjDdC4fXoeti96JRTi9ZGDT1TWjfTH/6W57IukH3+0jD4p/IpYWNpJIqglXObyGPP29QG2ewzNKXV0O1ynbTmKdNP17ZJDxaSP5mB7CcwbCCnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579318; c=relaxed/simple;
	bh=X3MNbtRFP5TThkU8MwiUQukk1cS8KR7cn4B6CPljE5s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HsrXXf59MrwS07uevbYVdK8aTtZLNYnNtP3NJ1F53aD5IYz/J7CLr0g29N8HA5huOiz0IRW70d45yTEUaBVTQgaV49d6hWmMM6/Z06o4Ml5QV9I3o0r8MFnbc7DS+ESna3iS4sMfj0sNXYv68Ul8TVM/C5hcdeDcGFwNFSiJa+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF1pQ0O5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF1pQ0O5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD6A1F000E9;
	Thu,  9 Jul 2026 06:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783579317;
	bh=DbmJ4H55ecd8aV4hAdjxFXgHksDpeIB+JXxAmclYzEc=;
	h=From:Subject:Date:To:Cc;
	b=LF1pQ0O5nJ2Z3Dm1Jm/fh4X8oEOM+VYR0N/Bk2fP0J7a2WkMAL1G6YnSpArGbDDsV
	 06hp/utqBr+CWqg3Ujy9AtP5wZbH9W3d87aCfzk5Gt/pXaVXCrrlTrQRd0jGTZVtPM
	 tgXAL+yxzpcaaPY25BLk7K8JHGzzuxRo3ckGJbWPMlfqB70iuGtS+DEzHDDueNEG4I
	 cdYz2VUjOg1CqmEiPuoBzP+AnCsbw3rThJu+U3Xvyok+GrGuok3fC2zru2/jWL1Zgd
	 ne0W2DbLlV/dj+uFacZ1znnXrCHWhH5qtXCTAA26kU9H+K+U6mm37COv2opKa2Kxmo
	 tM8Dj4NmEGa9w==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/3] mm: split a couple of headers from internal.h
Date: Thu, 09 Jul 2026 09:41:46 +0300
Message-Id: <20260709-internal-h-v1-0-956d5092782d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKpCT2oC/yWMyw7CIBBFf6WZtRMpJtT4K8YF0EHGyNQAPpKm/
 y7o8tzcc1YolJkKnIYVMr248CINxt0APlq5EvLcGLTSRk1qQpZKWewdI2oKFIxRh+M4QxMemQJ
 /frHz5c/l6W7kay/0h7OF0GUrPvYppaWmfUoo9IZt+wLt6tKojQAAAA==
X-Change-ID: 20260707-internal-h-2efef660381d
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, 
 Alexander Potapenko <glider@google.com>, 
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>, 
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Zi Yan <ziy@nvidia.com>, kasan-dev@googlegroups.com, 
 kexec@lists.infradead.org, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16-dev

mm/internal.h becomes more and more bloated.

Split declarations related to mm_init, memblock, vmalloc and sparse into
new headers.

---
Mike Rapoport (Microsoft) (3):
      mm: split out mm_init and memblock declarations from internal.h
      mm: split out sparse declarations from internal.h
      mm: split out vmalloc declarations from internal.h

 MAINTAINERS                        |   3 +
 kernel/liveupdate/kexec_handover.c |   3 +-
 mm/cma.c                           |   1 +
 mm/execmem.c                       |   1 +
 mm/hugetlb.c                       |   1 +
 mm/internal.h                      | 183 -------------------------------------
 mm/kmsan/hooks.c                   |   1 +
 mm/kmsan/shadow.c                  |   1 +
 mm/memblock.c                      |   1 +
 mm/memory_hotplug.c                |   1 +
 mm/mm_init.c                       |   3 +
 mm/mm_init.h                       | 120 ++++++++++++++++++++++++
 mm/page_alloc.c                    |   1 +
 mm/percpu-vm.c                     |   1 +
 mm/sparse-vmemmap.c                |   2 +
 mm/sparse.c                        |   2 +
 mm/sparse.h                        |  63 +++++++++++++
 mm/vmalloc.c                       |   1 +
 mm/vmalloc.h                       |  46 ++++++++++
 19 files changed, 251 insertions(+), 184 deletions(-)
---
base-commit: 820d5dfede0cd55dcbc89ce96fcfbb11b7c457ba
change-id: 20260707-internal-h-2efef660381d

--
Sincerely yours,
Mike.

