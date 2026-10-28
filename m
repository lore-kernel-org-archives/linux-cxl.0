Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793172274;
	b=f5Ca0KipKdYzVNW69ZieCAAXl9ubzC/tn2vUXCcph26WZxMu+PeMnxfpUiprvIKuoJo0
	 TSgYyicfddjo+RlA1piXXOiVgRuz+EgTIWI5N3uq+lH8zT85A5IvmuXn0gf+GzMcX/xyO
	 OS4TlRuOQUrTt36AGrpgk5OnlQgr3iEzDKaH6nzUnLbLJHM3etcSxJtnTtq1XwSzPHjHg
	 Dqy0WpJNjbX5s5gYai6jKYQ5bPApCyUvFGLR1zEAMer25QLJBahALdpUVUxK19w/xCOD/
	 u1aHV18swbhhzmsxF8pLeiPFHvxdVvU0suAlZK9LzTHejawEkq5jeneGejtx6Rs5aUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793172274;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=wjKIzg4DURX5JwuSS4RHjX9narjqVEsJDloXEia4pwc=;
	b=MjbDLDzgAALClc2ipU90iq4Ii+080ua7FVfKF53iIsP1vHBO396+PeLBXxEqhPevjw1M
	 QipiqP0240a8s6OwogvlNdcEdc14Mz5MQ1QMUmhziOL9SJvdzK/wynrTDlYfgZ879FXDO
	 SIsmYcqzVPEj6kse6ca5VuJJNctmhhRoBs0yKZHR0G/sB2YwjLD32zG6TYY8nGmbh+X6V
	 u1XYr0pXnrzJ+fhAsjzLUjAon9LDrnI4zHusR7LZ/eMotv+cueTZEtQFAZN53zh/2dxTS
	 rmPMDHeZl+pIbZI1OHRMWfauVA5QWqhjiE+cBBRJvTeC7bQb32+ytxTB6AtLxGZWq4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dGKxKGol;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18631606A321
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 07:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18631606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dGKxKGol
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793172273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wjKIzg4DURX5JwuSS4RHjX9narjqVEsJDloXEia4pwc=;
	b=dGKxKGolRKJzElRN+nXx8t9L8iI+eWZGYXiJJApX0jKyzyiHmRtgI+JOB+3hcmbiaBzmuv
	h6gHJXhc5hgfUmdfxp8iPueAto8M5agxV9n39AoxF2CAfyc3xN+z2dcqr2hXHiSGwVJOxD
	Yu/1168St8aRXzx7jJxttWbLUKd3qIE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-zLPm7iqEONebWVguyx4cIg-1; Wed, 28 Oct 2026 03:24:31 -0400
X-MC-Unique: zLPm7iqEONebWVguyx4cIg-1
X-Mimecast-MFC-AGG-ID: zLPm7iqEONebWVguyx4cIg_1793172270
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48dfaaea30cso429240f8f.0
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 00:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793172270; x=1793777070;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wjKIzg4DURX5JwuSS4RHjX9narjqVEsJDloXEia4pwc=;
        b=zBDTrWXTfsTdS9oxPcFomwqLn3iER5DZ5Xx/veUvIYRd8pPK5BIN0fd4FLJGeuuWpL
         JrAUe7+YRroR/KdZY+lrBZYfGmoaZjErHCqjukixGfJ3HJaErjmAvXWH6m9cXfPQAmxW
         VNVNQItPYpouhA0lM2c3djGe4B9OerZbrnWtOuzGPCfsEZ5uea/TWPDFXb2mK2xHhM/Y
         Lvgl8r2sKsh/S+sSPjOXNhLpRT0ebw5ziEk1w2VxYT1sd98vYL9FAcOjPB3DMfWoqOU+
         WkIpkyx+F2+dOpa1x4uPJ3dBIsthVuAIgBfIwpFoUMRhSFXiv+VPqToou4XKOMqVFtfC
         94mQ==
X-Forwarded-Encrypted: i=1; AKwUvBzoPEqcYA7Ga+31qyAa088m74aA9eCE9KQW4jDdxAAmafRoAWbdKzCcjkKC95hqj1cmZetRPgF/xps=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPl2JDlmi1/VN7gE3ypM1XIVVsSPJnvKYgznMPOBDf+H+3LNwf
	T1KmmTcltV3OMFLxu84VQNx04FgqDpaO+66cCmOs0kuTWGCrG4c3OvqOvDROn2SBN2dKlHQxKVi
	+TILCLPP7UuE2I22IUkIHE+3FzqA/zAHFxUPi06wY8i2KsWR+/vkoyan71xs2ZQ==
X-Gm-Gg: AYBFou0KsMVeu77sEkKEnklF0VL1BVVU/e7gRiQvBL/3Wm01eKXYxjlfQldlbOLNig+
	3kNwf+K+43lO4s4mul5BMWFPmzt68vi72PuGElyf+/JtP8zTBOs6TDJlBVKnLuSkmxnHq0c08pQ
	GT8wozR5cVwkvRjFSaN7ABuF49Nzu/xikE7I0M2tr5aokjEv8VALYTU3Io50ouv1LSEpGVzfDMm
	WxFE7Mb2+hvizDW+rcrAWryHIfhpFrm5JqEsrcZIRW1s1IuFzGkEmGRSQCbZkFoEIjciGWYx0HW
	TBuwTAcR17E/q33rJiJDovwGQgDG/gdxswbGsiO07ui1P1g44W0h3zfY8KTDEZJw5OuTQAY3D7e
	gqI1JvuMvpkX30EyljYSoPTMA5E/pE0GoGtSxmG0k
X-Received: by 2002:adf:e19b:0:b0:48e:3df8:74cb with SMTP id ffacd0b85a97d-48e5d45a44cmr4167971f8f.6.1793172270093;
        Wed, 28 Oct 2026 00:24:30 -0700 (PDT)
X-Received: by 2002:adf:e19b:0:b0:48e:3df8:74cb with SMTP id ffacd0b85a97d-48e5d45a44cmr4167913f8f.6.1793172269597;
        Wed, 28 Oct 2026 00:24:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3cfasm26832587f8f.17.2026.10.28.00.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 00:24:28 -0700 (PDT)
Date: Wed, 28 Oct 2026 03:24:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Junjie Cao <junjie.cao@linux.dev>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
	qemu-devel@nongnu.org, jic23@kernel.org, anisa.su@samsung.com,
	linux-cxl@vger.kernel.org, junjie.cao@intel.com
Subject: Re: [PATCH] MAINTAINERS: Update Junjie Cao's email address
Message-ID: <20261028032407-mutt-send-email-mst@kernel.org>
References: <02d394e6-eafe-4a3d-9f63-61b639267aa8@oss.qualcomm.com>
 <20261028021551.498530-1-junjie.cao@linux.dev>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261028021551.498530-1-junjie.cao@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JYechwyjGJw4RAHxYJYAYXztzZx9_FSLSdwkv-X4x-Y_1793172270
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Oct 27, 2026 at 09:15:51PM -0500, Junjie Cao wrote:
> Hi Philippe,
> 
> On Tue, 27 Oct 2026 19:20:21 +0100, Philippe Mathieu-Daudé wrote:
> > On 21/10/26 15:43, Junjie Cao wrote:
> >> -R: Junjie Cao <junjie.cao@intel.com>
> >
> > Could you Ack from your other email?
> 
> Sorry, I've already completed my handover at Intel and no longer have
> access to that mailbox.
> 
> If it helps, this aw99706 kernel driver patch from August is
> DKIM-signed by intel.com and has linux.dev as author and SoB:
> https://lore.kernel.org/all/20260804030255.1934470-2-junjie.cao@intel.com/raw

ok, will apply then.

