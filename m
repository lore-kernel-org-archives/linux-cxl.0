Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6887262F;
	Mon, 13 Apr 2026 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095046; cv=none; b=dN5f0xdAZsQdtYCqbpnOeWP1aBBN9HrlaTNMVnZoUmsylcu7mvmru+Ww0famDNkcnyAIuU0Y0KxK69yBkOw7K5S5l58ciLTjpvsAyqRHUzsj53bASqdwufoYQdEo0NJMT1x7MZbYNYQGJ9rsqHHiQLcnnGgGT18UlhpQI/tgByw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095046; c=relaxed/simple;
	bh=4qYbspDYQJcmOhz1JJFBn7ZGQBe0oN+RPtMUDJK/VmY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJbdzCDkv2KxQSf9WEfxuiUM28YcfzLV5ePOpHT0rOCsV0yNlrY/AabZJC8hf4lChRmt6PNlhFj45DcZjcmW6QhMEjQW9CPhpQGlcD26Tx8f39SxnqYyw/jc+8DwKXszbjR8MEztAcdNwM+jcynZR+tWEcweKmAA6JMYfYRQuwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fvWsc4QhrzHnH5R;
	Mon, 13 Apr 2026 23:43:48 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id EF9D540587;
	Mon, 13 Apr 2026 23:44:00 +0800 (CST)
Received: from localhost (10.203.86.132) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 13 Apr
 2026 16:44:00 +0100
Date: Mon, 13 Apr 2026 16:43:59 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Hannes Reinecke <hare@suse.de>
CC: lsf-pc <lsf-pc@lists.linux-foundation.org>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Strategies for memory deallocation/movement
 for Dynamic Capacity Pooling
Message-ID: <20260413164359.00001c86@huawei.com>
In-Reply-To: <e06deabf-44ad-4f3f-b817-78506c5e3203@suse.de>
References: <e06deabf-44ad-4f3f-b817-78506c5e3203@suse.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 30 Mar 2026 09:59:56 +0200
Hannes Reinecke <hare@suse.de> wrote:

> Hi all,
> 
> during discussion with our partners regarding implementing dynamic 
> capacity devices (DCD) on CXL the question has been brought up if
> we can somehow 'steer' which memory page to move.
> The problem is that for dynamic capacity devices we have a certain
> freedom which memory page to move/deallocate, so ideally there would
> be a strategy which pages to move/deallocate.

Hi Hannes,

Can you talk through your use model a little bit more?
I'm guessing this is about untagged DCD being used in a virtio-mem
like way?  Hence you want to clear out a range of DPA base so you can
do a partial release?

I may have completely missed what you are targetting though so an
example would be great.

> Should it be per application/cgroup?
> Does it make sense to move individual pages from one application/cgroup
> or would it be better to move all pages from the application/cgroup?
> Should we implement something (eg via madvise()) to allow applicaitons
> to influence the policy?
> If so, what would that be?
> 
> So quite some things to discuss; however, not sure if this isn't too
> much of an arcane topic which should rather be directed at places like
> LPC. But I'll let the PC decide.

Superficially feels a bit arcane, particularly as we are currently
kicking untagged memory into the long grass as there are too many
open questions on how to present it at all (e.g. related to Gregory's
recent work on private nodes).  On recent CXL sync calls the proposal
has been to do tagged memory first and only support allocation of
all memory with a given tag in one go and full release.

Anyhow, sounds like the sort of thing I'm always keen to discuss
but I'm not going to be at LSFMM this year.

Jonathan

> 
> Cheers,
> 
> Hannes

