Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DEC320CD1
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222324; cv=none; b=meGjuy8do1insFqbco1MsJYdxOPruFa2VlZxG/EHYchJnfWcskDjsMWsArDDwO29NWpILKyhNRYh+W8RpMDxIHIvmpyynmgnIJlVks+Rcu8+WZ2AphbiYGaLmrbcDxkXnm2m2jDT/jGQMxKz5E1d3TIzz1LbA/zONiH7T0ZspxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222324; c=relaxed/simple;
	bh=N1pj52V/YH8TuVI+JZfE6Z8xxvYmF8UJlQCFRfc5ipI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EL59U42kQiDq1RCg+iomD9g6eWBY9wi0NNhtelkfI/AzHXeQfOWkcj18VGSL2FFsUqzjd3ZMZR7jedMIliVCZq6T0Mb1PDPk7/f3p19bt5fAfksqn/OMzpD3Mg9N50OgWw+ixqFVHpM5cY1T+crQWjz6QQjYyorWTZ/NL4q7JZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G/AhxrKq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G/AhxrKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE741F000E9;
	Tue, 19 May 2026 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779222323;
	bh=VDssL1JLJxE+xcjIOV/X2qrzoQDIuhvVsBuZSSJ5o50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G/AhxrKqZylZHoao3naUtVqUOBVx2Z80edFedYunyMmpFrNKy1Nyw+LbcVmZziH+v
	 Ey8lX+XfkJizl377m4ouZp5vlg750X6TzVR++3cspgCIzcGUW9o2AuVxxHb4WDqqO+
	 ba75mcVuDECO/FB3DSFXGLVgujDjixASzVt+lweM=
Date: Tue, 19 May 2026 13:25:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
Cc: david@kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org,
 osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 djakov@kernel.org, Mike Rapoport <rppt@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2] drivers/base/memory: set mem->altmap after
 successful device registration
Message-Id: <20260519132522.421c018b39328ebc4767dd8e@linux-foundation.org>
In-Reply-To: <20260514092657.3057141-1-georgi.djakov@oss.qualcomm.com>
References: <20260514092657.3057141-1-georgi.djakov@oss.qualcomm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 02:26:57 -0700 Georgi Djakov <georgi.djakov@oss.qualcomm.com> wrote:

> If __add_memory_block() fails at xa_store() (under memory pressure
> for example), device_unregister() is called, which eventually
> triggers memory_block_release() with mem->altmap still set, causing
> a WARN_ON(mem->altmap).

That isn't good.

> This was triggered by modifying virtio-mem
> driver.
> 
> Fix this by delaying the assignment of mem->altmap until after
> __add_memory_block() has succeeded.
> 
> Fixes: 1a8c64e11043 ("mm/memory_hotplug: embed vmem_altmap details in memory block")

Patch is nice and simple so I'll add a cc:stable to this, even though
the issue seems rather minor.

btw, AI review had no issue with your change but might have found a bug
in create_altmaps_and_memory_blocks():

	https://sashiko.dev/#/patchset/20260514092657.3057141-1-georgi.djakov@oss.qualcomm.com


