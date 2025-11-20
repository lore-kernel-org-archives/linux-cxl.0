Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D68372ADC
	for <linux-cxl@vger.kernel.org>; Thu, 20 Nov 2025 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763640314; cv=none; b=bHaVivNrr74s8r5UOFchNjDKLLN7INPkTHiRnW7QjaLzd7HaxdICZyt9lFtnG/C4ytsMe7uLkTkm53n7gBYm4DHXQIbDAbXvAGFftiQ+82KlsdDyuZwbQmrIQbyodrql3gDGMpTXE7KBd8CKa52hwUQcteQpx2zGm9U5UMANU7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763640314; c=relaxed/simple;
	bh=5Uzd3tC60R46c0DaRRbvIIaOvV8AddSoXq8IRkQQtU0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=egWrCEeOB0FZJ8ll9TITdh6aKApu/8ha4d4mt5wCswyQlkr9KQAXhDBkD94YQEQSsa5XiRdFCH79+YCuunb4Z4XIaGtPZpH9vsBPdVcSRXP1ouKipgSJaBEJOhRx5n7ALOBFoz7LGhMGGBEJcbN96JuqvTkRI1+30MN9VkiPYOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTHdB32t; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTHdB32t"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-55b0d4b560aso1198611e0c.0
        for <linux-cxl@vger.kernel.org>; Thu, 20 Nov 2025 04:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763640311; x=1764245111; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Uzd3tC60R46c0DaRRbvIIaOvV8AddSoXq8IRkQQtU0=;
        b=ZTHdB32t+Ea5FTywiloeuJxc8iCbZJYhcqDHLZfpbM608Gnk6+9j0BE0FnIGhcMUxi
         iLx00DTjrSnjvDB/dVtmAs7oC2ERe3ge2/uyhcP1ffJx6ADvUENA5W0/rigB9jbrJigv
         ty666Zk6twzzrpwK7Sj5+I4w0cST+k3K55SuLNemqDhll8f/Zg9NEMd6z/PmiLP3pArU
         WMq5Er+mi7qHexgUwsOGTPghGqkcIMXKoSnaeAaVqJp0eVbgkklj4ZbnUPvFHJE/5I9v
         KJCdsuG/861I8ZPVjhnIMZB1Ce+dkdwJXxS+OxOunjIsEGpdsn97Vbcboeix9s4EqO88
         h/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763640311; x=1764245111;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Uzd3tC60R46c0DaRRbvIIaOvV8AddSoXq8IRkQQtU0=;
        b=PnWPlVCWFHEXpC4E4xqVAts8yO0Bq5xmOTkX4ByWZhtEmGBxFCLufZkzPBljpbsc5q
         dkBhNl6XDFld2tAlRWukBd3SUE5AP2h++44DAcoi+f5uWJ6ywEWy4iISLL8x7uPhxba+
         mH/XAEEhGVqAoH9zFdHsLfkf5Vd4CMW04szfJJ1pIvLsH+AspTIXriXvwES5Vmne7bkd
         DLMsc1z4qDPT7OTmssQzwmUamx1a0nQmYvtryZg7kZ1kRCxHEgoHxDQtIG0gbPhk8d3e
         B6BNc3VjqrnaHAro6eu69CMunWgjw7F0sSiRU0tiBIx8qNYsgrdbZbNa2n5MX6lT+3lc
         3ARg==
X-Gm-Message-State: AOJu0YwK94mRhC0oA//xz/TfrkW+J4BHE4FJrYJDeZ3T3VMMNIjPFi4C
	Xgk/k56/NE6JaQ0MmhjWrNcpdrxgV9uTRG9Bp83Uc3JiH4Uiq3EDAYw/M4J3ItWKBijEcU+gOdY
	0RARK/sMobMsHGNSGO9LdIZnqcVoQw280Kl87cbA=
X-Gm-Gg: ASbGncs+O7VXZg0Oez/FlqmO8tid5FL+RfMPbefshyvFRartfNATRKpcjgNDvjwR0IH
	RzjgjSe017S8lNl9rQ0eEZ7PGpwjTwhQpjdlwHsV6jXixC2nXFrx7hk1k8FKbN6VhsitpSCN6MQ
	x+iumRGxzNUPsXf45pNJXBaVZFjswmOQSJgAzOGYSvKAFt2IirxcUm86AixVB+XbSKdju6q2PqW
	uYbxhFY+M8EhhUkYbRQyMn1rLmDOd3B9ytD32uyUw+f8chQftdJh7gqxYE15NCnXWJy+PMF8TFY
	poNZEjSW270QcTfDL1+x+5gB451AFuHgTXcNxSGkuny4JMcAcdumSYUNVK8=
X-Google-Smtp-Source: AGHT+IGzfIbIJTD4msuRDmPqshEiaAvraYExoGliYza3BnEvKZ0mSXVWP1CnJ1qd00l5WqyRqbURT7qcJstryniYZXM=
X-Received: by 2002:a05:6102:6444:b0:5d5:f6ae:3903 with SMTP id
 ada2fe7eead31-5e1c41bae5fmr701876137.20.1763640311317; Thu, 20 Nov 2025
 04:05:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Arvind Nanjundaswamy <nanjundaswamy.arvind@gmail.com>
Date: Thu, 20 Nov 2025 17:34:59 +0530
X-Gm-Features: AWmQ_bmmbdnSRsPT1m6GSf9Jtb7nFKW4F8yH-6tDp7f4AyPBOmurxEECpNtrwJc
Message-ID: <CAK8XrEWTauMKpWpuzfnpxGuY3gbr8EuuoAgaHm+awyhZnZ3EiQ@mail.gmail.com>
Subject: Interest in contributing to the CXL community
To: linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello All,

I'm Aravind, ex-HP-UX kernel developer and have worked in virtual
memory solutions during 2002 - 2010. I have a decent understanding of
system architecture and its programming aspects related to VM. I have
worked on ccNUMA extensions, memory Online/offline solutions and
enabling largepage support.

I have ventured elsewhere since 2010 and want to get back to VM
development, especially about CXL implications on VM operations.

I'm open to taking up small beginner-friendly patches since this is my
first time contributing to the community. I'm looking for mentors who
can help me through the process.

Kindly help.

Thank you,
Aravind Nanjundaswamy
