Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C831C84AB;
	Mon, 21 Apr 2025 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745262653; cv=none; b=n/ftPWsh1hJfiodH404/JZjGcs6NXOBr7bz3Vp+gr7D+VnpPKFzl6s1fVPi1W8/OX3Wf0BxKDcJqA2iQJU8GpfkXh6pYEQxAai30FJ6FrSZXEguKt7h8msnyYboYHwr/SlqOdHA/xaCgBN0lgO0fnfQg8Ysi3WW2uj1x4Dr/liE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745262653; c=relaxed/simple;
	bh=lIko2PLVSmH39atI+9eygRcc6+YXTwEAH8wJ5UnclOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kufBGPzO7ix63wrFx97/FJZf61yoRjQUdjMI7XiCdwZVZ95apjs1gActAVgcOFQSLugywZoJ8UXy4wommriZY6M6CN5n/mneDPCyA8MIQkaB8UtB4sm+tMr+N3RgeJGan4oUJxEDxPOqIiC0jsnRBTnlhWbOwJdof+u4MvLFdWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1723FC4CEE4;
	Mon, 21 Apr 2025 19:10:50 +0000 (UTC)
Date: Mon, 21 Apr 2025 15:12:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "shaikh.kamal" <shaikhkamal2012@gmail.com>
Cc: dan.j.williams@intel.com, Davidlohr Bueso <dave@stgolabs.net>, Jonathan
 Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Fabio M. De Francesco"
 <fabio.m.de.francesco@linux.intel.com>, Smita Koralahalli
 <Smita.KoralahalliChannabasappa@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH] cxl: trace: Fix macro safety in
 CXL_EVT_TP_fast_assign
Message-ID: <20250421151239.7981f1fa@gandalf.local.home>
In-Reply-To: <20250421184520.154714-1-shaikhkamal2012@gmail.com>
References: <20250421184520.154714-1-shaikhkamal2012@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 00:15:17 +0530
"shaikh.kamal" <shaikhkamal2012@gmail.com> wrote:

> Fix checkpatch.pl detected error

First, checkpatch.pl should never be used on existing code unless it's
yours. As the name suggests, it's for checking patches. It's not to check
what's already been accepted. Please do not submit patches against accepted
code because of what checkpatch.pl reports.

If you run it on code and it reports something that you find is a real bug,
then sure, fix it. But don't submit patches on code you do not understand
just because checkpatch.pl says there's an issue with it.

> The CXL_EVT_TP_fast_assign macro assigns multiple fields, but does not
> wrap the body in a `do { ... } while (0)` block. This can lead to
> unexpected behavior when used in conditional branches.

Next, this is not a normal macro. It's a trace event macro and
checkpatch.pl fails miserably on pretty much all tracing macros.

> 
> Add checks to ensure cxlmd is valid before accessing its fields.

If it is invalid, and we do what your patch suggests and just not write
anything, the event it was writing into has already been created. If we
exit out of this macro, then the event will simply contain garbage, but is
already on its way to user space. That means the output to user space will
be garbage. That's a bug. In other words, if cxlmd is NULL, it had better
not be calling this macro in the fist place!

-- Steve
