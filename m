Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ED03911BD;
	Thu, 10 Sep 2026 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073766; cv=none; b=hrsZSDW9Aqau1Bi3ehjO/OXfeG4RgePgvHaO5fp7COBWovAPr0wCge1NPwxmBceOgu6SPBwlUNh7PQ845ojRNTX1z/WIGzL2aZk3sLDTLQDwhb0DVEc7q4/aPx6abyc08rbRVJdcqZ2lcBTsSj1jQi6lppui5V/VhJU3fUB+YEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073766; c=relaxed/simple;
	bh=h8rCaR4TFhDM8T589IyyHriDF3DobxfKqx5fLSskxtg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R91HFokWTBPtPjBpD+G+kTs3yEq46Lg2JtizTt+98znfcE3tUPEzPmMqpqQDAq+/9Hxxl/VHjIb0Zln86dyHYqj1niofOt5btaOTaCkin5EqOeJNnKyWMvZhYAc4fmq2zNFq0RooY9jSONH7bhemz647jnDZDIHrIHVBME8ElvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTynoEnc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTynoEnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FFB1F000FF;
	Thu, 10 Sep 2026 20:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789073764;
	bh=JZqyxO+0mZ5PkddrCrsh7wBL5SNaKqyzIqNlNs0WVhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cTynoEncsSZadaZgn9MhAhOeYYU+2V2bQb1y/rji8feAnOgMJhLfpGDOyYTvT8B+B
	 efSdWhcXzufQYa0XaJ2ls651lAABBROis38uKVTh56cZVIkgxqSSllb6wAJVl++7au
	 GCHmHUm05yQG6i6FfvQTaB/iltUJ1pzVS012/RngrOfcCJ/foR1hqGV9wTMDB9cZ9w
	 zOrYsxRNJVIXAZhDVR5aZiSUS7kJfERbvLvof2RalR+E38hti14vvkj+6B+klhm9fV
	 xtO/DtE2cB7EiDU8hPm+Yx9jktPnh+Y56l9ZuYkBvDLuDuey6I2sKMw1TLPVgFIPwH
	 n80CWHjp9g9zw==
Date: Thu, 10 Sep 2026 21:55:59 +0100
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
Subject: Re: [PATCH v3 1/2] driver core: Add conditional guard support for
 device_trylock()
Message-ID: <20260910215559.38257fed@jic23-hlaptop>
In-Reply-To: <20260910094017.4032170-2-kanie@linux.alibaba.com>
References: <20260910094017.4032170-1-kanie@linux.alibaba.com>
	<20260910094017.4032170-2-kanie@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 17:40:16 +0800
Guixin Liu <kanie@linux.alibaba.com> wrote:

> Introduce a conditional guard version of device_trylock() for scenarios
> that must not block on the device lock. device_trylock() returns 1 on
> success like mutex_trylock(), so the default binary condition applies and
> ACQUIRE_ERR() reports -EBUSY on contention.
> 
> Suggested-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
