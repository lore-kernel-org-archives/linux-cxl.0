Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AFA75814
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441896; cv=none; b=WleNbvC1cjflLLs1Y/RQXQijyC6arY5raYOPIpKjW4msQ5ekW5wYRW9HqYxlB3wPVBGSAWhxNc+bZNizEg251zGXVMSsLBt4NviLUQKxdA8MTn3zUlRbZu1t0o4O0MgO06+gR0P5f5cZQ6jRD6NYcCAGZFXnez9XyhXFOLt3Teg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441896; c=relaxed/simple;
	bh=MviKsFi5iupfTf+oenKJ8QckCxHYuVMi+RNLFsKX7JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQOgadjZHpli+pj2s03M1OZrCW9ZoSb1+HHg6GmxrO1M0LPIoHmplCXABLy4tEhLB8imbwAMSGuYHmbvt6udZ2bTGtxm47FQ9iwUcNS6X5IG7Wr03C9FqIEmVsJzN6Rl7iROKMoFxKrhJ0B4DIQ9vaSzQE/FtmtObkGnehE3EdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA6AC433C7;
	Thu, 14 Mar 2024 18:44:54 +0000 (UTC)
Date: Thu, 14 Mar 2024 14:47:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
 <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/trace: Initialize cxl_poison region name to NULL
Message-ID: <20240314144706.0ac5c0f2@gandalf.local.home>
In-Reply-To: <20240314144405.2ae1d16a@gandalf.local.home>
References: <20240314044301.2108650-1-alison.schofield@intel.com>
	<65f3016b8b0d9_1fe3d329441@iweiny-mobl.notmuch>
	<ZfMuDlDbVHtlAL8z@aschofie-mobl2>
	<20240314144405.2ae1d16a@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 14:44:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

>   #define __string(buf, str)		len = strlen(str); buf = malloc(len)
>   #define __assign_str(buf, str)	strcpy(buf, str)
> 
> I also mentioned that __string() does much more. It can handle NULL
> pointers, so it's more like:
> 
>   #define __string(buf, str)     len = str ? strlen(str) : strlen("null"); buf = malloc(len)
>   #define __assign_str(buf, str)  if (str) strcpy(buf, str); else strcpy(buf, "null")

BTW, the above is just pseudo code, I'm ignoring the bug of the missing "+ 1" in malloc ;-)

-- Steve
