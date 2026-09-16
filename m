Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F020435DA41
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 00:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519465; cv=none; b=R1aLcl5aKvTnDL0t37I5gBh0bPxr5FQRmaohDSuLagNMHDId42NOrv7AjVncC7cHmdzF1iRtnObuJv1BIjgFfKszh6JM1iAKiWW9FF8srIHhyx4b3bGOHNgICfC+0UPdnMO3xivUlOIb3qVRyM74YKBcC6qcdk18mI1Vggai+UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519465; c=relaxed/simple;
	bh=wg3XVTwlq5lbXK7YfjhC3uVF0UCw8OITcKQFzxxG5As=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxD3iiHQRhtYUoJMlWoUJjU2t7PL68JxSKkIe1EQI377qTZnWKC+x/EC10SXvf69xwmEngX0exuNTuu1u3QgihGMEnhfzt/miEKDZNhqencX//XU99THx9bR6UBrIrphqBuE+mCisf0dLQSE0cUPZcXk6p/IpR1FOoOxhiDbq1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyW3DMhq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyW3DMhq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B69F1F000FF;
	Wed, 16 Sep 2026 00:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789519459;
	bh=toApqf6jsV9jTNO1v3YnvxQbx0c8XWTui/N5a3Ln6y4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DyW3DMhq9PUsUutYvKJsCdM6TTwPPt5iE6u9DfS/aFBXFptL6jKi9EBIuQy066POC
	 HuKF+3yeGhAzZBE5qXJKziBugMpeA0bh34L0NkARLTo5xc5D3DXB1F11Dvjia2v9H1
	 jzyJCjlIpk+da95qMcvvlDZ7yLrKBZ9nA5sJArjRp61D4K79Fnn+bLQI9h2wTx5SCN
	 /8orL6mMxfbNj4eo6H7hiMSKwqVZJBcQULW/5Z7N1eGcEbV41xVAhjS1gPu4J4sfH5
	 o+D4p127mIlAhOy3CfS/bH02R9K861PsYMUpcvWOlhneJPFbMRKDXNiGjbpbPwJtmo
	 5MQiv8VQS04uQ==
Date: Wed, 16 Sep 2026 01:44:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/core: Skip einj_inject creation when
 devm_add_action_or_reset() fails
Message-ID: <20260916014413.183eb4b5@jic23-hlaptop>
In-Reply-To: <20260915060138.2007974-1-kanie@linux.alibaba.com>
References: <20260915060138.2007974-1-kanie@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 14:01:38 +0800
Guixin Liu <kanie@linux.alibaba.com> wrote:

> cxl_debugfs_create_dport_dir() ignores the devm_add_action_or_reset()
> result and creates the einj_inject file below @dir unconditionally.
> 
> When the devres allocation fails, remove_debugfs() has already run
> before devm_add_action_or_reset() returns, i.e. debugfs_remove() has
> released @dir. The subsequent debugfs_create_file() would then use
> that dentry as its parent although its final reference was dropped in
> the removal and its memory is subject to call_rcu() delayed freeing.
> 
> Skip the file creation in that case, consistent with how the rest of
> the helper tolerates debugfs failures.
> 
> Fixes: 9185b1a3043c ("cxl/core: Fix dport use-after-free via the einj_inject debugfs file")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
