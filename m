Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879EB428488;
	Thu, 30 Apr 2026 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564260; cv=none; b=hKzj79zJ8DbHQ+RdhBEN0vtqCg74LYoy18sdWA6JZCmmwT/JFcPXJWHi6XxIK3kI5FtoZvsbZiEwQL3F/YG1oI+O1HT4rtqMhkhNljrpQ7Lr6xWEjTSyOfI8QxwiP7Lu4M0rRsUUUnzykk55inzzMp9FW/CM3ad35O+mF2dSimM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564260; c=relaxed/simple;
	bh=VCwG/evqvBgdVG6GZCPvR18G1PtMuMNk/bVzaUD/ngU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=R6WpFZ/ZDtX7c+jjf5v7rw407EEX9L0RC6rymOImUnWVDcm3J8lnPlIVJ/YvvkNC+H/0+tY+hGX5U0eKNdNfwhHxkFa1XKkPUFD1TTi8eMK2n/EprjOmlJJnVX4UWgkbYa2ox7BBPYrNi12MfUa7WUL0EvHbaLyGtUxSWISnX30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yGMSUjDg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yGMSUjDg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B317C2BCB3;
	Thu, 30 Apr 2026 15:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777564260;
	bh=VCwG/evqvBgdVG6GZCPvR18G1PtMuMNk/bVzaUD/ngU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yGMSUjDgcVWPfy1XYK0lJb4V8O16KsRRfBKQd/aD3cP6f+SYk9+hc2V4ICklHG6Sj
	 8FHN0MJm3/mmxi77yGWm44pVUzUvRaAI3Dic1FDgpQoeCiZb1DBtUS4Ox2Qt5CKpny
	 DuATWvnLOZDOFrVfhmkJR9Z6CfVrsiieyIbmhRoo=
Date: Thu, 30 Apr 2026 08:50:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Usama Arif
 <usama.arif@linux.dev>, Oscar Salvador <osalvador@suse.de>, Miaohe Lin
 <linmiaohe@huawei.com>, Muchun Song <songmuchun@bytedance.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ying Huang
 <huang.ying.caritas@gmail.com>, Dan Williams <djbw@kernel.org>, Naoya
 Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Rafael J Wysocki <rafael@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 3/3] drivers/base/memory: fix locking for poison
 accounting lookup
Message-Id: <20260430085058.f566bdc2aa5c19a54936da30@linux-foundation.org>
In-Reply-To: <C2C5188E-76BF-444C-BF2D-8BDC1410BC61@linux.dev>
References: <20260429101134.1358607-1-usama.arif@linux.dev>
	<b67ff3f9-8661-45cc-b408-6a7b611d31c1@kernel.org>
	<C2C5188E-76BF-444C-BF2D-8BDC1410BC61@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 15:59:33 +0800 Muchun Song <muchun.song@linux.dev> wrote:

> >> Lockdep would flag this as sleeping while atomic when acquiring mutex I think.
> > 
> > Another thought would be, that we always call the inc/sub from memory failure
> > code while we hold a folio reference and the page is not poisoned yet.
> > 
> > That way, memory offlining cannot continue and the memory block cannot go away.
> > 
> > So we'd let out page reference keep the memory block alive.
> 
> It seems unnecessary to hold lock_device_hotplug if the user already holds a
> refcount on the page. I'd like to drop this patch.

Dropped, thanks.

mm-hotfixes-unstable still has

"mm/memory_hotplug: fix memory block reference leak on remove"
and
"drivers/base/memory: fix memory block reference leak in poison accounting"
