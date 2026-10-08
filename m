Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D9D3CF1F2
	for <linux-cxl@vger.kernel.org>; Thu,  8 Oct 2026 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791442749; cv=pass; b=AWCewksxrPD6RCGHgcpZfrQc3cZhy66TP2z1MHwjlIOjUvQmQ6BPQh44BwnavhrmDAi4Q+q41A9pDRFG0HH7wI7LH3CSNS+Xo4D6DdGRZZkQknKrI0/X/sRWRS5ViUF+XJAUH9oPDXNRiEEkzoye9KEsbgsVxSnX+5PFbYF/ij4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791442749; c=relaxed/simple;
	bh=1W5Sxy12Ogp8A7y6gf9ny6a0gyAw1CRnfeolqgDZBYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9pHZTMzl4x8Rd+BZsFu4FNVKIMKkqzEPmzOs3n5lVLDqbeDQZ0s/ieFp1MtJzwyj9F6tVnT57J1cXgk3g+NJVQaFLVxMviqXg8XRj94ufvBl72u28hBbdV4trODDuSf+WiXRRu3fwtk4dSsmd3V1aipMqzKrLoheUPdxqFh/gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=rEhMkPp+; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rEhMkPp+"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-534e6545939so39692251cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 07 Oct 2026 23:59:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791442746; cv=none;
        d=google.com; s=arc-20260327;
        b=AWhYS5CL0CTavIIfq13uFP3CIPkW8kyQ3E6ufEphIm/sM2RIze94/NtHV7uV86o3U2
         4woMi/c1srCxfeUVE8cr5UKk7So1uwuzt4IS0EFzy5hYhXWIedCQSj9ENMfatHBArMaQ
         azFgGLWHdlMilMArHLjtMyyoI17Ww/kDmZKgDGSVwt9zELJmO1fpue+z8VH7mx0MvYrf
         GXBGTnil6Y2K4fbENSKSI2Lms32QW9l4dKwVdbqzaTSd94/RTsaQ2X0x6tSW4Ezd61n9
         B1YmafBch7TmT3MDQIe+MFLXiW9sptpdWWF2sN/FceoVC8IzjX86L+pwHzvBWStayzgb
         zaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L3hU4nbWl8LrfKz8yVK4ZzMdYbOShSdSRkPWsTycbt8=;
        fh=ASwHmtkruN5ZR3jgr6cccE+6yCGnH2BHmZKhY63Lyr8=;
        b=MQfcpbRaNorpz4eAYZpeCl91YcnDv8OtJArkHAwbN0QnJIexJngf7SwJ5mnmxrCJ8U
         hwTysraZ/RHShif9gqi5OPfTfWk4A3TRPmrVFDY/ACHD+y5dvSoztVCEwe+xD6uX82RK
         HTkyZT7BD1v8v3wlvX8FUijLv9dJgOlvxH6cjLyPKQ7IhB+TA+VAeZihXeoD1zRqIdt7
         v5eZ6barXwEKkTVHfG8VZiMTmi3MNbErJwxNRrCRxgPzK08iajzK7pq14Mk60R+cWcFp
         QK7o9t8eB4BO1bG+SjBJKiJYKIm8RYK/V3K6ENYzv4HMMYBJcTJb2muHN6/csJT59YQn
         MQpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1791442746; x=1792047546; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L3hU4nbWl8LrfKz8yVK4ZzMdYbOShSdSRkPWsTycbt8=;
        b=rEhMkPp+LOxRltChGJDrMR/Z6VjofOzn30JRIqUGoOwWNhQ+G0A50V9izeS6NjZqP3
         3rc7xenQYL5xSWo/xIZroTwTesYniSvF0hJmZ9CctlXw3QQ1El9hJJHFPJBBCChinB4k
         acNSMNf8jVcK46Oer2DFQoT+soGM4IpOu33mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791442746; x=1792047546;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L3hU4nbWl8LrfKz8yVK4ZzMdYbOShSdSRkPWsTycbt8=;
        b=F6sufwtDKNv0M23I6zyqm/tWlpqT+M2cM9uXaak99HkR61xBtKnnIofLhh9u7Ue7Lj
         WiFLYoiY9SajhUi6noNRAQ1+BjElRiMdcS0ACI3Wma0Hcfl9muUAmiNXgxRVqT6UD/gk
         nkELevcYhdufVGo+W5KZHFSAaba3/hK6RJN3UwwCc2LvhYTAXORn0Q8uHJdqy2YmZEUo
         NNmNsW6/ti1xeQqtYcLoueDZStvcWrBYkCvWS6b04ztIoXOuGMrl3xpid5QROtD9TeXY
         w67RtORtH3RpK3Va0VD0d/Qvthh6IgRYW2ZKB7p/FFUGovr/JTJf+YgI67/fukzOMdvN
         yjwA==
X-Forwarded-Encrypted: i=1; AKwUvBxYm9R6iEYKShGNKlOITVKsT5POziFEWnhGqHmYQew1AgYEZM4dP+w1yICv1rChVBHkGogaEY51UGc=@vger.kernel.org
X-Gm-Message-State: AFuF++mC7mbYfmvn4INZ48vPHDUHULIB8DzN5x/JhRe6OodMgB/xPJ+K
	L0ijcpgVB22wYC311V6maI02tkyvrUHQqcS9WNDUpn88mcXogVAEZFg8Cp6oQn/7Ugabq+4defL
	1ZjbxBv1g6obNEe/CUSov8i71EnJw3MG2jDs5YUkjOzATQ/7EqP6Q
X-Gm-Gg: AYBFou0VoqEZ1cXnfgQt71dYm1k9vqR3cURZgWzxM3o1ibYKnsXwO2haU2QbCkv+9VC
	qeAsK5pN9p5Aigq1fvGFul/MKCmP4niQz3aIniIDZvj1gDhZXJjmSyPTHXeWfCd2hOoXUhLdRZr
	zKI44KAie08zV6Hx3Atm+gB/hu1EJ/ue6khAClWvNtH6pHpr0aK1IG7ulpdRMGFctDKvH2Bxgsr
	yiJpRxPAz86LeHYjap9KOq/YlLBj4Q6gHJRN3D9ZUBaE5FjLdaizQ8ACFERvJx309c5cwPuDO0J
	mIoFOjx6FS0QF/Zx9DuX4MrXZLdHmmF3bJz3xPB2AYD7prWEGxG3+EHSAhGr4AqiqI/ENsmSR5S
	0RU/p67PIksbNWjqvtwxyFsw=
X-Received: by 2002:ac8:5a49:0:b0:535:10be:7d5e with SMTP id
 d75a77b69052e-53575545a1cmr89724491cf.46.1791442746044; Wed, 07 Oct 2026
 23:59:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006180115.1425232-1-mszeredi@redhat.com> <20261006180115.1425232-3-mszeredi@redhat.com>
 <asbrrhh0BrBDDOkj@aschofie-mobl2.lan>
In-Reply-To: <asbrrhh0BrBDDOkj@aschofie-mobl2.lan>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 8 Oct 2026 08:58:54 +0200
X-Gm-Features: AclHuK9mcs0U3g8nRj25-jK3khFgy-18rAJm04RUxSKhCvNJcpCBMTzwyQNv4BE
Message-ID: <CAJfpeguxsc2ehKK9cDWx4r8Mk-VNQHGU9Soag=-qzowVkoosxA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] dax: use READ_ONCE() in dax_holder()
To: Alison Schofield <alison.schofield@intel.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	John Groves <john@groves.net>, Amir Goldstein <amir73il@gmail.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Oct 2026 at 03:03, Alison Schofield
<alison.schofield@intel.com> wrote:
> As written, it suggests that READ_ONCE() makes a non-NULL result safe against
> concurrent fs_put_dax(). However, READ_ONCE() only controls the pointer load, but
> IIUC it does not protect the lifetime of the returned holder.

Right, the changelog was a bit hurried.  Will fix.

> Also, is this RCU-based lifetime handling specific to the new FUSE implementation,
> or is it intended to establish a general requirement for DAX holders and callers
> of dax_holder()?

I haven't looked.  The RCU based fix only works as long as the memory
failure handler doesn't need to sleep.   I cannot make a comment on
the xfs code.

Thanks,
Miklos
