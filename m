Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D2C6FB9;
	Fri, 11 Apr 2025 03:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744341091; cv=none; b=PyuQAw3TZw5KtwpjXy/hmATm+S3Xry+ArJXuaAdrtxQGJeqhIBa7tNZgs0z5JB5zJGusMy9q3fIc7wtZjoFUCpELGh9rTPS/kQZFnjsFfqS3UMskGTQLUvMtmPPpENa4bTT3kDXu9IVHJFGU+yQlzn00yzF7dEpLBdhEN3ufLAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744341091; c=relaxed/simple;
	bh=+I1LKR5/GFel5Hnsw++Z7Q1F/FET2wm6yRqFmjbIVmA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XDCV2BK5Ck2ACsU1yLVwGHQhbaswMd5gwJ3wqhmJTXqxZNLTt+s55YXuTNZN744gq2Stz3VBOOtO8rnMqO0clAZ4bAwPx+sZYP9PE2uIL0MuvSH5svh+btWF4uxQNcHnYOrcYN4n6oMF6m1zyde2jD+6iC2KR3F/MRdFv2O9DJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gtCLTFGg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gtCLTFGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4954EC4CEDD;
	Fri, 11 Apr 2025 03:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744341090;
	bh=+I1LKR5/GFel5Hnsw++Z7Q1F/FET2wm6yRqFmjbIVmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gtCLTFGgRKY6euMdDXye/Rn3aGQFaJQUjvO+8duaHDulgk6VjvxGQa6wu3241kEla
	 tvSWVm2wTyRpqO7F8agliERkDylSoP6IB/UkQUnmuMPp9GABwRAaknq0m46r6KBMzX
	 gmu3kbLrywL+4phpVCJ2KVmusqbwNd1Ky42lQqWw=
Date: Thu, 10 Apr 2025 20:11:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Rakie Kim <rakie.kim@sk.com>
Cc: gourry@gourry.net, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, joshua.hahnjy@gmail.com,
 ying.huang@linux.alibaba.com, david@redhat.com,
 Jonathan.Cameron@huawei.com, osalvador@suse.de, kernel_team@skhynix.com,
 honggyu.kim@sk.com, yunjeong.mun@sk.com, Dan Williams
 <dan.j.williams@intel.com>
Subject: Re: [PATCH v7 2/3] mm/mempolicy: Prepare weighted interleave sysfs
 for memory hotplug
Message-Id: <20250410201129.59daece11914dc086bd32f2c@linux-foundation.org>
In-Reply-To: <20250410080629.564-1-rakie.kim@sk.com>
References: <20250410075341.549-1-rakie.kim@sk.com>
	<20250410080629.564-1-rakie.kim@sk.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 17:06:19 +0900 Rakie Kim <rakie.kim@sk.com> wrote:

> I sincerely apologize for the inconvenience. It appears that this commit still
> requires additional corrections. I would appreciate it if you could drop the
> changes you merged into -mm, mm-new branch yesterday.

No problems, it happens, glad to be of service.  Dropped.
