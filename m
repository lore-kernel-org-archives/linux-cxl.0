Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0055020D4F0
	for <linux-cxl@vger.kernel.org>; Tue, 29 Sep 2026 02:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648361; cv=none; b=WF4RYKyyY9lLum8FmuMkX4glBeJE+TW1vziBY+qW+v0reh2SkT2H7oH7S9ITzJNg9YQuAJUuZ/M29TpWt2d8OdOVZSh7FIs+wbagGRBGOSr92o9sZn3jzdxLj4DcTlL/sCvw4CDMqZcFKKI3R1Wa3q8b+LmP+JURusyjWltjzCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648361; c=relaxed/simple;
	bh=VyDzE1HWTIbYIzAVUN4Qj2F9BawV1bNHvifZfzzst8c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oJAR9FxQE74s/EIapssD6pYlPyYBAvGJ9fpiM1Bkl7O/ulfXL1/g3gSAgX959Q7iWSC4jrcc2Iazd0lKxM8ofTDuGNnuaIlGrt4xbzjARtZtn0mbvLOqw4hG3OAQP3XobEqA7fZT+rIGmfBXxvoLENgtQ8h71Zh/0QT4RR0Er2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wo6cVxZV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wo6cVxZV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B8B1F000FF;
	Tue, 29 Sep 2026 02:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790648359;
	bh=SJtS+HMCnN5AOoqyfUzJdR9/wfQlOU4+W8j+O5JTiqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wo6cVxZVTdJvKpywpCraXzWPWNNcEP+e+UcJv/AxPYlktfbI7u7p4/WpYXTkbg2hw
	 GAGPcumGoieb0XNMnT/9162YUsxrGbMr8q7Ulm1OgB9HKAGuituAsMEd+cwPwVA1dB
	 UEHxaK36jCxBpRQjtW/NLXWV8G6Y8IV5e4TepkxguM/TsCMWLY/sg2Zgzw/ocCYeCb
	 j7D0H6umdEJAXYyaMP2Xul2MViijUlmhu8qMJmVABQY2gKHp5qPoBjWOPJCniEWCrb
	 mG9XV/PutfDOU7C6egad36TykbMBy72i9/zcVhGSItbpT12R5wp78rdGvvEeM2vhYf
	 0QqX2AqmqKD8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] PCI: Return -ETIMEOUT when reset readiness polling
 expires
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260929020405.9724-3-icheng@nvidia.com>
References: <20260929020405.9724-1-icheng@nvidia.com>
 <20260929020405.9724-3-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 02:19:19 +0000
Message-Id: <20260929021919.A4B8B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: breaking reset fallback leaves devices permanently wedged on =
timeout
--

commit 4617b1cca51c668aae8c9b4809552b80cdac13dd
Author: Richard Cheng <icheng@nvidia.com>

PCI: Return -ETIMEOUT when reset readiness polling expires

This patch modifies pci_dev_wait() to return -ETIMEDOUT instead of
-ENOTTY when a device fails to become ready. The commit message notes
this stops the reset-method fallback.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6461274bdbcf9..d59a374a350d8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1279,7 +1279,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *=
reset_type, int timeout)
>  		if (delay > timeout) {
>  			pci_err(dev, "not ready %dms after %s; giving up\n",
>  				delay - 1, reset_type);
> -			return -ENOTTY;
> +			return -ETIMEDOUT;
>  		}

[Severity: High]
Will this regression leave devices permanently wedged if they hang during a
soft reset like a function level reset?

Looking at __pci_reset_function_locked() in drivers/pci/pci.c:

	for (i =3D 0; i < ARRAY_SIZE(pci_reset_fn_methods); i++) {
		...
		rc =3D method->reset_fn(dev, false);
		...
		if (rc !=3D -ENOTTY)
			return rc;
	}

The fallback loop aborts on any error other than -ENOTTY.

Previously, if a device hung during a function level reset and
pci_dev_wait() timed out, it would return -ENOTTY. This allowed the
fallback mechanism to try a stronger reset method like a secondary bus
reset to recover the device.

By stopping this fallback, could userspace applications and virtual machine
guests using vfio permanently wedge an assigned device that has a buggy
reset implementation, instead of falling back to a secondary bus reset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929020405.9724=
-1-icheng@nvidia.com?part=3D2
