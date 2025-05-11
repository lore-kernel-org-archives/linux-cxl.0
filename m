Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9961433993;
	Sun, 11 May 2025 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746948872; cv=none; b=uGy2WjnsqX4bMr3CbGLW2ZZTcsPSe089ewEjeXvJ7XWOojFixnkQ7hujERZ3W136pctHaKJZ1A8LN5cQXscNb7GW6aDkkxzFRmiL/INfeQsGD/CXKCbT/GJSux5mJBwh5rDn9EvQX4L0/QOL5VNd7hhGqH4x3r8yHp69Yputls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746948872; c=relaxed/simple;
	bh=L5bDgSVU+y5XpSpBhQGTTcXujMH1XhEYgnVMxUvchi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWpqs/X37yYiYAU/faJbFA9eJbCd5tjODPxiCrwxQA5UNGA4wNE569OY/NiWoZYpPhqjJeiSaQbVYGYeGCnbQAw+m8jW29j0SE+hfJS1iUwDUSiwUKu9fSVP45LyefuW4qA681UzhbLgerh1SFaeJHZM8vy8nM3NlolfFVZ2lsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+i4IMZf; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+i4IMZf"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30aa79ee726so3358126a91.2;
        Sun, 11 May 2025 00:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746948870; x=1747553670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=it1jgVAGXIxAqOM+Uac0zyfaV/HqVJYi5SUSH+vLp+M=;
        b=h+i4IMZfteHzie6M84Ol5r/EmEPfthlxu3h4H9te9pbHseH/LdDP7Wq47Xq9FCOLqD
         3BwEm5WfY4Mi5jWS+n4T0PDbNaQei2PAy0p5Xul3ESUhDRG/11o7jW4w27fYmRnUqlo8
         E8W4QZl+feVCrGiEwAevKDW0mCpU16ZVwbP3suUQaauWXYYI/ks673JefEv8pZawcIQf
         9DxPNz/gcDiDh1z3lGil33OX68p+8BpttDZEjm44PjTlIQzYdKi3GDWFc266KwoEy06D
         Hntg7gi/W3p8LcoomHg03i1W8XQPMyiwno8k9CVSciInXuJQKkhhRP3438CSM7gbASBP
         T3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746948870; x=1747553670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=it1jgVAGXIxAqOM+Uac0zyfaV/HqVJYi5SUSH+vLp+M=;
        b=uzxHI+0wcvcRt2shxrSPtxiYQakE1YSwbWnPo8qw6TLbKLwPyymabwjjDTCMpc5VvI
         ulvnlP/Ixdlqn+LyelKvXSYLkJCOOfGB/koiaVB4x5XUHuv0pyEGoJsKLEN2XfTctUHD
         D910j7rU1HHccB8RG2/hCPezfOfZLwwOhSrHU1e3VpTqLEGcEJbdPsYgGba5LqbewwAX
         v4CbA1zWHePwmz7QC3D0Ygo1p0rH69qAdyAfGvxt1zxf41SF/Y9v78muJo1PxfEKceRU
         8BMwJeaJK9G7nNf+EIHLu4OZeNdiHBnVbWEECZImZBHZIsp3mt7lEmb2azQjUlia4qcq
         LF1g==
X-Forwarded-Encrypted: i=1; AJvYcCUOH8xl7pxMYQW1PLMV5NLYzpB/xwaHQIZDquggIwNqxr1JegUa7HiapKl3GQlUN51VZ+m9HpBnInehJDbl@vger.kernel.org, AJvYcCVugMtnBgqAn3/f7nGLxkx9KBclacQsoKxct+f7gSRUo9MeqDYnAcAJzjTgBgAa60EcXx6JLOotXOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw45WhgFC9FewDXDt/VniDYttAxA05KgxTSM0MaD+9gM6WdnslZ
	17lGVcS8c7NOy7Oj4eyQEdejQiK+uZjSkp7eYhOqGwYzyUWwDMFu
X-Gm-Gg: ASbGncsyGhtdGW6F8XJMwoXsEM7GEj6fWnJBXnmkU0WNYz0zTR4nAM3EvbY4qzRg7iN
	IxRcFFpRZ/puwXCf18mRm3lKnJwLtQR26meA2GzMmW5u21fkKtlrmWKEHL+mQa0yF0QWH8ezCSA
	iSahoCmLVdqMcXEiT3euwFHLYt4YX0yGjud34jzUXyy6i9ogwGRB938EMMLR6q7ZQDz0ol9lFLx
	MteBXl8fArlv9GkskIZzVuDYuDPeO7wTdT1P8uznCGIDYdUoqGfyQO6yoeHWW1Wo4WE3ISAUQHt
	9805uS037dAvnFL2/6fmh25bfy9RCyQiwCqMZGh/vIItRpah8OQ=
X-Google-Smtp-Source: AGHT+IHc6V50FA87z2Q7A089ljZXgQsRymXfVthqDfWQ8t0QtsRIHvRnddIAC9ZOFDKz2NlbgeRbvQ==
X-Received: by 2002:a17:90b:498e:b0:30c:4ae1:5f5a with SMTP id 98e67ed59e1d1-30c4ae1628emr11906374a91.29.1746948869504;
        Sun, 11 May 2025 00:34:29 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad39d66b8sm6727225a91.0.2025.05.11.00.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 00:34:28 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 4FD254201B85; Sun, 11 May 2025 14:34:26 +0700 (WIB)
Date: Sun, 11 May 2025 14:34:25 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net
Subject: Re: [RFC PATCH v2 01/18] cxl: update documentation structure in prep
 for new docs
Message-ID: <aCBTAX4SHMbgHSRO@archie.me>
References: <20250430181048.1197475-1-gourry@gourry.net>
 <20250430181048.1197475-2-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e/FhX3eNGBJ3Dabn"
Content-Disposition: inline
In-Reply-To: <20250430181048.1197475-2-gourry@gourry.net>


--e/FhX3eNGBJ3Dabn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 02:10:31PM -0400, Gregory Price wrote:
>  rename Documentation/driver-api/cxl/{ =3D> linux}/access-coordinates.rst=
 (100%)

Not strictly related to this patch is I'm seeing example hierarchy diagram =
in
access-coordinates.rst renders in htmldocs output as long-running paragraph,
so I wrap it in literal code-block:

---- >8 ----
diff --git a/Documentation/driver-api/cxl/linux/access-coordinates.rst b/Do=
cumentation/driver-api/cxl/linux/access-coordinates.rst
index 77ba9be9af2d60..cd6d66cdf9e691 100644
--- a/Documentation/driver-api/cxl/linux/access-coordinates.rst
+++ b/Documentation/driver-api/cxl/linux/access-coordinates.rst
@@ -27,20 +27,20 @@ a CXL Host Bridge (HB). There can be multiple HBs under=
 a CXL Fixed Memory
 Window Structure (CFMWS) in the
 Documentation/driver-api/cxl/platform/acpi/cedt.rst.
=20
-An example hierarchy:
+An example hierarchy::
=20
->                CFMWS 0
->                  |
->         _________|_________
->        |                   |
->    ACPI0017-0          ACPI0017-1
-> GP0/HB0/ACPI0016-0   GP1/HB1/ACPI0016-1
->    |          |        |           |
->   RP0        RP1      RP2         RP3
->    |          |        |           |
->  SW 0       SW 1     SW 2        SW 3
->  |   |      |   |    |   |       |   |
-> EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7
+                CFMWS 0
+                  |
+         _________|_________
+        |                   |
+    ACPI0017-0          ACPI0017-1
+ GP0/HB0/ACPI0016-0   GP1/HB1/ACPI0016-1
+    |          |        |           |
+   RP0        RP1      RP2         RP3
+    |          |        |           |
+  SW 0       SW 1     SW 2        SW 3
+  |   |      |   |    |   |       |   |
+ EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7
=20
 Computation for the example hierarchy:
=20

The fixup may be added as separate commit.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--e/FhX3eNGBJ3Dabn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaCBS+wAKCRD2uYlJVVFO
o7znAQClW0rJrtRRGmj+fFued5Tuotz4AVzfhIRnBTv0i5yKJAEAm1tatH6RNchn
0uww92w1m1PL0Ip8iX8c876t7fH6hwU=
=GSlU
-----END PGP SIGNATURE-----

--e/FhX3eNGBJ3Dabn--
