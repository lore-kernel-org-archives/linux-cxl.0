Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB511CA9;
	Fri, 10 Jul 2026 00:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783642416; cv=none; b=J+M0v3+9XjFI8eRTjuFhxB4TDBoZHAFTtaSfU1Gol71ilSHIAbEgAuWT617maSkOwQAhs1S4d7ZfDf4sMzx+LbYq1PuX1/uyFIv2ht4ucci1PMQFWHTkhXWbPB4y5XXHx4XuEL7OSpttqb8kiNdieV2r2UPK5v2IejQBK35l7r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783642416; c=relaxed/simple;
	bh=XlSocjBUUvgvKawDHf5pd+lK6U6y1wYW5H6KwJUSNuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smy7ve76R0NkLuovqLA6d9h2CP6g8YBIsXcE+bej7kthvaU4ly8ZrvUOCKNdl/vAf98N/edmJ0/DOaaejGri40F30AZe+ouqmP78az4P5UVWE11OTAU7vb8XnkcqZr39PVfyDcqZq7AWkhYrWw6g5zPbKnrEK8VjuOpEDNmSquQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUyXaCZA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUyXaCZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63B81F000E9;
	Fri, 10 Jul 2026 00:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783642414;
	bh=9gjBmaqSneqTuRoIZKmkOm++Q8E0rqDqKSQfqW/IN64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KUyXaCZAaX3ttnttEEVV/zT4iS+V7t0wzxg+ALl7LU7XP+H5rZ4vcZ9K0mwASjdKd
	 98z37XWKnBN3JSgoRN8caw4/S9K98lzFFehmZjq9hOo8rkQC1uWXYXsMekk0zkxVyQ
	 WWFZTcox/X8ToOmCS2e+ev/feYTtU9T7ZM5kWBL7cVK4UoLTJmb/h42Di5LXTKuGO2
	 aOwnamxhd2bD3iLH4hZxQEjnK+q7zhlp3YR8tnI87sXVHbk4+EvMQgfR+GNtxsXtTL
	 OmsHiyPSmTfaqxdRILAtu/Jd2JjEf3B7kN/V6xOkOqU4bWdgGxZsCJPMt+IfVu+eUt
	 RRuJtj2DMafnw==
From: SJ Park <sj@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Alexander Potapenko <glider@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Marco Elver <elver@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	kasan-dev@googlegroups.com,
	kexec@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/3] mm: split a couple of headers from internal.h
Date: Thu,  9 Jul 2026 17:13:25 -0700
Message-ID: <20260710001326.110758-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709-internal-h-v2-0-695631425968@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 09 Jul 2026 13:00:02 +0300 "Mike Rapoport (Microsoft)" <rppt@kernel.org> wrote:

> mm/internal.h becomes more and more bloated.
> 
> Split declarations related to mm_init, memblock, vmalloc and sparse into
> new headers.

Nice.  I also confirmed I can successfully build mm/ for my main test setup
after applying this series.

For the series,

Acked-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
