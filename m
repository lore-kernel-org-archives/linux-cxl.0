Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CEC39A80E;
	Thu, 10 Sep 2026 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074218; cv=none; b=j1h7jr+CdMThUyWWzg/fPaT9jylZnylM8lW6Z8tY6JQBzEr+kdR1oSGsbUnC1OteLdLCGJl/BONugukXsywhOA/C5rnKMpEKdleo42qdSSpNpmWIK0BykyEqitd2FXG2EvDU8thfmrN8+GQoAexJ502VaI8n5LAtvD8xE8PPt7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074218; c=relaxed/simple;
	bh=z5KW+U1P7kNcxrfXlEy7/26AmYjL6a54t6COMlAGvxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R12IEL/ake85yJArjMiGNItVIG4s1fgX4ALV/jqh6glDfTJ85htZ+NUuNBnoQDwXL+0lUdPkjaTmOOf5hTxkacJAfrqFWlMzf1Bubef/qmM5jlOr5cxzsSfm/kgb0dYVTSd+wNjIg/IbGwE8kSWWps/C5veSygsqhKjiZIA3zJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHpv5qrj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHpv5qrj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282B01F000FF;
	Thu, 10 Sep 2026 21:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789074217;
	bh=nzMw3pGMiVMXkctVyIAOS70gZu7Fa/3l4yJ5Nml/tz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AHpv5qrjbkWQxW7fOldkiu7A/o4hSm5/dzp7zfZCEMMhH6cjnTQE+alsS9i3Rsttg
	 DEpMXg7IgHEzGpr+SNar7u+FlpCsoSQSXdKmmXulDaceVGVmfdbcVShsPHfiaPmkGM
	 damEGGhNCiIp174cTtL3t4mAQ8mBKtSrae8aa3vnTttBolNO8Uzwt6wjBEpc9B+hn8
	 +sUt87rxCTopihukbUnX6j31lRtyfc3x3DxQNwJZAtxwbo/AQQ9cEVah7nVypEA9lL
	 mROVjOJbfccp1jDzbSX1u6pKTelxgzyDe4QLbQkTwzOWWFVDbGhS2gIiY0H18flqo3
	 2HlsqNF6f/e7A==
Date: Thu, 10 Sep 2026 22:03:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Shaikh Kamaluddin
 <shaikhkamal2012@gmail.com>, linux-cxl@vger.kernel.org,
 driver-core@lists.linux.dev
Subject: Re: [PATCH v3 2/2] cxl/memdev: Fix deadlock between poison debugfs
 and cxl_mem unbind
Message-ID: <20260910220329.20b62302@jic23-hlaptop>
In-Reply-To: <20260910094017.4032170-3-kanie@linux.alibaba.com>
References: <20260910094017.4032170-1-kanie@linux.alibaba.com>
	<20260910094017.4032170-3-kanie@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 17:40:17 +0800
Guixin Liu <kanie@linux.alibaba.com> wrote:

> The poison debugfs handlers take the memdev device lock so that the
> region lookup sees a stable cxlmd->dev.driver. debugfs holds a reference
> on the file across the handler, and cxl_mem unbind removes that file
> while holding the very same device lock, so a handler that waits for the
> lock deadlocks against a concurrent unbind.
> 
> Both tasks then hang. The unbind side is uninterruptible, and it also
> blocks the memdev detach work, which runs on an ordered workqueue and so
> stalls every other CXL bus work item.
> 
> Take the lock with the trylock guard and return -EBUSY instead of
> waiting. An unbind that wins the race removes the file first and the
> write fails with -ENOENT.
> 
> Found by code inspection. Reproduced by writing inject_poison in a loop
> while unbinding and rebinding cxl_mem, and confirmed fixed by the same
> test.
> 
> Fixes: 574eda81d0a7 ("cxl/memdev: Hold memdev lock during memdev poison injection/clear")
> Suggested-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Probably not one to rush in but nice to clean up the deadlock even if it
is a little hard to hit.  If it is possible to test with a hot remove
flow even better.  You should be able to do that with emulation in qemu
if you don't have hardware capable of safe hotplug operations.

> ---
> checkpatch reports "do not use assignment in if condition" twice, on the
> two ACQUIRE_ERR() lines. Those are pre-existing: the unpatched file and
> the Fixes: commit report the same two, this patch only swaps the lock
> class on them, and the combined form is what all 40 ACQUIRE_ERR() call
> sites in drivers/cxl use.

We should fix that up. Oddly I thought we had, but guess not.

> 
>  drivers/cxl/mem.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 798e5c369cfc..3959ec963026 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -50,8 +50,13 @@ static int cxl_debugfs_poison_inject(void *data, u64 dpa)
>  	struct cxl_memdev *cxlmd = data;
>  	int rc;
>  
> -	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
> -	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> +	/*
> +	 * Never wait for this lock: the debugfs proxy holds a file reference
> +	 * across the callback and unbind removes the file under the same
> +	 * device lock, so waiting here deadlocks against unbind.
> +	 */
> +	ACQUIRE(device_try, devlock)(&cxlmd->dev);
> +	if ((rc = ACQUIRE_ERR(device_try, &devlock)))
>  		return rc;
>  
>  	return cxl_inject_poison(cxlmd, dpa);
> @@ -65,8 +70,9 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
>  	struct cxl_memdev *cxlmd = data;
>  	int rc;
>  
> -	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
> -	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> +	/* Never wait, per the inject path above. */
> +	ACQUIRE(device_try, devlock)(&cxlmd->dev);
> +	if ((rc = ACQUIRE_ERR(device_try, &devlock)))
>  		return rc;
>  
>  	return cxl_clear_poison(cxlmd, dpa);

