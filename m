Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1B4A1A
	for <linux-cxl@vger.kernel.org>; Thu, 27 Feb 2025 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642781; cv=none; b=WjwmW0QZLcqqq9WNPpu4IroWzlgf7xiUEAEAD+9mDX/CGNT8zTiENI6zWVuKHEZM60/bc2+YNCawtPTKasj98hIUYSoaKd74Atw+MDmJivwrnpp0whhrMT6HkyE6d1J85AMJXbcrxH4ly9nFST5wYRjWxJufQzI26iJlH3aQ7Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642781; c=relaxed/simple;
	bh=WAve0K61aiBm2H/kJcL9Z33ely0mkl7umME78jtqWNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecvsZTwylBtUMP9GGR3bZK3sHicrHf0VyfmjeQUJWNqYti6XtJdy5gChgsq1nLeepgjscYxue/yDsDk0ozFWv67w2kD7BVS1dv/WjExsI0yBF7hxpnwIeRo90gvCI/GvwaowvpE9KWDexgp6e0wn3knyIshYQNtDUdJQY0D1M3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SXOLHzql; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SXOLHzql"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f31f7731fso279202f8f.0
        for <linux-cxl@vger.kernel.org>; Wed, 26 Feb 2025 23:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740642778; x=1741247578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAve0K61aiBm2H/kJcL9Z33ely0mkl7umME78jtqWNk=;
        b=SXOLHzqlXhxb4jvoRIJJaRW67+Z98sGduAmYGrPWU3Nv3sqgsuWk5SGGYZOIJNweKv
         jZyVHAFgoG7SwGXnIhbPxSLO8GoxDQzEEEUp4EJJCnyj/xFWCRAA8DnqbvoKrFk1pEjY
         i+M5RNocw+yifwWy7D0XS6xCsYcA/p0TN5Jt0k0rhB1vGZyjwFHeyt7waolqBXl7wROH
         upGc4/G4Wyp/ObOZy54Hjwy5BSCKBUIbowxvSSQkUnxMnLOHEFp+604fLOCZouQxcnLf
         6nDfRxTb0sUkhHTbgpIBYFGd+tfACLBqmaZW8sM9rUe03FevcsAYOcAtVJeaOAmqUfcm
         u7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740642778; x=1741247578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAve0K61aiBm2H/kJcL9Z33ely0mkl7umME78jtqWNk=;
        b=jKnOCTb7m4IptvAwbirUgVwgwOJLG9jw7wsS6i4wdCJwgLkXESaWhy48wP5o3Ryugp
         NO7p2x9FUhG9aE6Jk6QHeeISFfhR0hkgpUcqXhOzPDzEGvfME5PTGeE/f+LdQRJm1rDD
         imuVu7K9bjqAk1lON41y4D+I2AQjAsegTzp/IEfApcuFbd0gsbZ4f0uwELxiSRQO4HEO
         LRHC2RTbsxeYDAaLKGe+aNHVMLVitwH/PAVONTold9QEiG2h1ck4uv48YBuzu7ORPN2Z
         Bup8B6FdUOu6Sp4NUfRPpdK6tzkKWaZN5dwL7OFyX8GGpoGKGIhX7aqTOoYxjQsh+0OT
         DM6Q==
X-Gm-Message-State: AOJu0YwRBgYykTZo8iX8rX+vb2PoV5r/SBr44xe8F86WFGxx5pejDJ4o
	ebu0KHT/UqJsOb1IKPJGgZrb40SZOBvuF4UynRBWxo2GZASeQcD3PLp1sUZfzfEg2fRQjnfqZTk
	DftzFr2RM+m5R54UmhF2UnybEVlAsjujvaO2y
X-Gm-Gg: ASbGncsiHtmIAE3YhvDAl5FAqsqIYyIj/6QFewePXQkvuNrKqfU4OkXk/3EL+bjBzqP
	XRc3ToMPkd1HISd8Wc+06tCKtOy8ExYsl3xnImQ9SNcqPWDaPpNOVe5jdb/94vaGv+ZQoJ9TDP9
	kpPK1qOquk
X-Google-Smtp-Source: AGHT+IHq/W1ckseU42DFdamVj9VolCNCEVXVrOQeYw+6Bv1YqodQtI+E8O2KwTAXHPbfpoMMUid6060aOourekauJZE=
X-Received: by 2002:a5d:6d87:0:b0:38f:4251:5971 with SMTP id
 ffacd0b85a97d-390d4f367a0mr4807927f8f.6.1740642777735; Wed, 26 Feb 2025
 23:52:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227030952.2319050-1-alistair@alistair23.me> <20250227030952.2319050-20-alistair@alistair23.me>
In-Reply-To: <20250227030952.2319050-20-alistair@alistair23.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 27 Feb 2025 08:52:45 +0100
X-Gm-Features: AQ5f1Jqr2f3px356CRZa1JK9YL4d2jGf-uxwiU32ka-YgAtLTMIEvy1EGdGheLc
Message-ID: <CAH5fLgjFvm-+jVpBsgU-sgOOzHic9DvcUMMg_z0G+37z5DWbPg@mail.gmail.com>
Subject: Re: [RFC v2 19/20] rust: allow extracting the buffer from a CString
To: Alistair Francis <alistair@alistair23.me>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, lukas@wunner.de, 
	linux-pci@vger.kernel.org, bhelgaas@google.com, Jonathan.Cameron@huawei.com, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com, wilfred.mallawa@wdc.com, 
	ojeda@kernel.org, alistair23@gmail.com, a.hindborg@kernel.org, 
	tmgross@umich.edu, gary@garyguo.net, alex.gaynor@gmail.com, 
	benno.lossin@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 4:12=E2=80=AFAM Alistair Francis <alistair@alistair=
23.me> wrote:
>
> The kernel CString is a wrapper aroud a KVec. This patch allows
> retrieving the underlying buffer and consuming the CString. This allows
> users to create a CString from a string and then retrieve the underlying
> buffer.
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

I believe the idiomatic naming for a method like this is `into_vec`.

Alice
