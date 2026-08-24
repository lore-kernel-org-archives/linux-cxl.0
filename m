Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8832DB79F;
	Mon, 24 Aug 2026 22:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787610606; cv=none; b=i8+53E4TrjcNrzrHIewROMbiqI2Xa6merNBo12OPAntBacvhqt8lDl91f4VOsbGi1MXftSuGjoUE7Q9CRKpEBzhwhBhE4+ANI0eCqG0J+R0NGCeNFwUvrFaslVpXBVdZI8h3QK8gg81tCmJgQogE+x+6Q+ZjzgYY4s8HkPVf+QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787610606; c=relaxed/simple;
	bh=eaDU+5tQTLljPjW8t9gn9AeffYCK4f4lFVUYsYJ+FGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3SA/CHzVboLxBnqCtErJ8l0/HoFqATwbTOviSuZj7YXr1V5Ekhs8cn1b48JFo9makUHKyIsFRO6+SKwmr/OFx8NYIA4VR1xqgCM7arocjWLOvgyaHxAiN6CIvpyQ2A6p/UiAnd+OxqmmDKPmV7Hy9XbJ6BIAYNGOB+fIAUtVbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhVSaJPI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhVSaJPI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869C21F00A3E;
	Mon, 24 Aug 2026 22:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787610604;
	bh=J7SuVIHitlL8jpWy2kSWmMi0P7zB4bZtrXFoTvGl14Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YhVSaJPIuXDxOyIqT1SYOmNkKjneHSaLUUF/CnBYTe2QULIz3nntcw3rIuobjECY2
	 UmPun2YBixXjxiXj5dqjWkGIPVTO/OR2afzxZiLq1Qlr+d5jnZaN2eEZdv4mxdMj5/
	 vRfjOBlJoWLuLDk7h2ahcwQwQ4VAZfyJQRYd3+NI+9mXBugCmUWGWWH2W5GTe01CSv
	 354CtH9C2qENj8yF4oVkJmCXENNNEQtNZ0bWTqKRFM4U6ixES/ZfkfLczOn+RhVGXZ
	 W0ajC8Rr0YqZpsYY85F3Icd6IFHD1OYGGZrR/zVUiRE+fUeux46WWnl1b5N9RqRAec
	 HsFE0wntDNvsg==
Date: Mon, 24 Aug 2026 23:29:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com,
 mchehab@kernel.org, xueshuai@linux.alibaba.com, terry.bowman@amd.com,
 benjamin.cheatham@amd.com, alison.schofield@intel.com,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/13] ACPI: extlog: Defer CXL protocol error
 handling to avoid lock inversion
Message-ID: <20260824232954.5600083d@jic23-huawei>
In-Reply-To: <20260824174936.939059-5-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
	<20260824174936.939059-5-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 10:49:27 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> extlog_print() calls cxl_cper_handle_prot_err() synchronously while the
> MCE notifier chain rwsem is held, and that path takes the PCI device_lock
> via guard(device)(). The probe path takes the two in the opposite order,
> holding device_lock while mce_register_decode_chain() takes the rwsem, so
> they can deadlock AB-BA.
> 
> ghes.c already avoids this by posting protocol errors to a kfifo and
> handling them from a workqueue via cxl_cper_post_prot_err(). Export that
> function and call it instead.
> 
> Declare it with the other CONFIG_ACPI_APEI_GHES exports rather than at the
> end of the header. No #else stub: ACPI_EXTLOG selects ACPI_APEI_GHES, so
> the only caller cannot exist without it.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Makes sense to standardize irrespective of all the other reasons!
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
