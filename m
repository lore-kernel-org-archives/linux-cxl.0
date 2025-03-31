Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE421DE4E3
	for <linux-cxl@vger.kernel.org>; Mon, 31 Mar 2025 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743449930; cv=none; b=n3mX5u5HiwbkUDU8u1wGlk+yBj7Uwbd2OlmmrqgVN+mgazU+sodZwjNy0f6x+RhfumnHH6bTSfEsaVdeLJBC86FKAyvdERNYfqZyZQdWJLGwg/uhtP7IIw2YuhKvlP0jQRbQhEXBkFiW4hYoOyys+BYtaG9+XsL/fQq0XYhP8UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743449930; c=relaxed/simple;
	bh=YXRFUDWs1gRMGsN/XKgOH5v1iYk73+fO5S7cRpQnoGE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdpG3N3P0HcL3sKnusOCJGiK+ku4uEFZL4PzzYeqfhkEKBAcXw5mwz7c8hVgzaw15pKZH3pyIaPJtglajn/H5sZQvRskjPU95Vih6kwBmRAXGmkT7Y9WhqpSka3R0Pkh8d4BH+0R6yjx6IDjxxyORfr+azoCcsrLpAhrQO0LGUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCZfZi9Y; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCZfZi9Y"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2243803b776so15207835ad.0
        for <linux-cxl@vger.kernel.org>; Mon, 31 Mar 2025 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743449928; x=1744054728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+iRYX/xQalMboqQgAbV2dXOcQ1A27wFDzT4V4vO6Vg=;
        b=CCZfZi9YKrwvA2NqoCDQXjHAlwKmrpbpO7Ucj+aarBz/8/ttsmHmvtnc22uLAziKwu
         mNE9F68bzdFWWju/OrQox/KjZ5sCGtU8LWRntEEY/B13AZYtgcgXPtzLpAw5W0mQ9r2d
         IliP7brdwl8XEzE3Gw+ARNGfgxXxOXpAO4OCX5jerzphZFhxLXEFTMZGuZHaObK1f0nG
         qs98ERTffrwuBm0tvbra9r200FkhbjaHFuM9YydWe3nWan7fGXrwM+wAAaNTF8oYO+IZ
         OeavD6wGHoyG7uLPyLjePbQ4EYaW1bmFkRhQVKhVC5V+lw8ooIWQ0ivjChRc0OzThvAF
         OQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743449928; x=1744054728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+iRYX/xQalMboqQgAbV2dXOcQ1A27wFDzT4V4vO6Vg=;
        b=JdjzfSOlpSRCZy2Sc+by27Bk/2kW+/Pc+qWCdIX0fMnu5dCN+ZzLURz+RbVYpLhLZp
         0xaZjHjrQ2IqYTTX/2YckbUs+jMZ3T+/875WNjEc1Yu5ijhrHnF/OglUkgK9+BJkavRD
         dLlZ7UFEbcj8KRXpguLVX2M9raognavAjzTIs5EJXBAh8/6h1tGDc4OLB0VZ3QRJBjAz
         QriM7eBtMulNZyrWKCVESLntyLiWP+7od75RyqKN7EoQX64HHbIZLK79JjSy/wfm4NOh
         b6RlZHkhFzCEDpQXOC8vxgyLJDRt6iKl+03d2XQnM6Q3k8ZbJ6KrQWBkEqCFFxSdWAFr
         QYBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAG27rz5cskOHrz2AxkCi3DpAUSkBse5Exf4ue5slGnu/rxNYDEOHqly/bEwBR7L07iTlgTxNLIcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpuhw2BWnqs49hIGOJPkem8TQUxjIHpd7W/x2qjSnyvw7z2o28
	URiDwzpHZ5k46FF+scoEmnU5mRqoqlet06rqSL2tjPo3U02+SYkrprqc8g==
X-Gm-Gg: ASbGnctCV2LjeTJMggkc5VW/P2QoVpMhvZ6z9FZK3HSeVyGurMeQHR7ZXZ+GFMhyTHf
	G7bB3sjD5jV7nNUMUGmdcsN8It5MpR8xj+PKduHhoXSOwe70bLDH0+p+PP8td0crOCepuYlFW6N
	c0H2ZXcw1oZ0twc8pUnqSEievARDOpkLauxTQ4vAfvpgjiwq0y1JkGej29bR0xqWq2DCU4+sPDZ
	z3KWgMGZrliDKSbeEEk1z8BW/4HQW0jy9A7yp6sadumeOS6Wf5EdTPUkgGu3+645bwdB8FK3K2W
	j34KqGZwqSukNcW2fiecAq82GbjBEc+731iWFwLRVMBZx/gLh6AetisyNGU926XQYP6FLz0=
X-Google-Smtp-Source: AGHT+IFwubbp+TUYm6LnGYSydAKGp+TxnqDtCNA8OFUZSc/zaXMKhfdTyYAENma4WqGllcOIM9jtHw==
X-Received: by 2002:a17:902:f54c:b0:224:1ec0:8a1a with SMTP id d9443c01a7336-2292fa09394mr124859875ad.51.1743449928273;
        Mon, 31 Mar 2025 12:38:48 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eec6fb2sm73360115ad.26.2025.03.31.12.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 12:38:47 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 31 Mar 2025 19:38:45 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/9] cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
Message-ID: <Z-rvRZUTUpT2Kv-S@deb-101020-bm01.eng.stellus.in>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-3-anisa.su887@gmail.com>
 <20250318155624.00006410@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318155624.00006410@huawei.com>

On Tue, Mar 18, 2025 at 03:56:24PM +0000, Jonathan Cameron wrote:
> On Mon, 17 Mar 2025 16:31:29 +0000
> anisa.su887@gmail.com wrote:
> 
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Section 7.6.7.6.1
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > --- a/hw/cxl/i2c_mctp_cxl.c
> > +++ b/hw/cxl/i2c_mctp_cxl.c
> > @@ -46,6 +46,9 @@
> >  /* Implementation choice - may make this configurable */
> >  #define MCTP_CXL_MAILBOX_BYTES 512
> >  
> > +/* Supported FMAPI Cmds */
> > +#define FMAPI_CMD_MAX_OPCODE 0x57
> > +
> >  typedef struct CXLMCTPMessage {
> >      /*
> >       * DSP0236 (MCTP Base) Integrity Check + Message Type
> > @@ -200,7 +203,8 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
> >          if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
> >                msg->command_set < 0x51) &&
> >              !(msg->message_type == MCTP_MT_CXL_FMAPI &&
> > -              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
> > +              msg->command_set >= 0x51 &&
> > +              msg->command_set < FMAPI_CMD_MAX_OPCODE)) {
> 
> Hmm. There is a visibility problem here we should address but probably not
> by introducing a new define.  Maybe we should move the enum from
> cxl-mailbox-utils.c in a precursor patch.
> 
> Jonathan
Thanks for the feedback and review Jonathan.

According to the comment above this condition, "Any command forming part
of the CXL FM-API command set... is valid only with the CXL Fabric
Manager API over MCTP binding (DSP0234)."

From my understanding, this check is to ensure that any message
sent from the FM API command set (0x51 - 0x59) has the MCTP_MT_CXL_FMAPI
binding and all other commands (opcode < 0x51) are are sent with the
MCTP_MT_CXL_TYPE3 binding.

Although I see from r3.2 Table 8-230 CXL Defined FM API Command Opcodes
that commands from sets 0x57-0x59 are prohibited from being implemented
in the MCTP CCI, would it be more correct to change the condition for
FMAPI commands  to msg->command_set < 0x59? Then if/when commands from sets
0x57-0x59 are implemented, if they are implemented according to the spec, they
should not be added to the FM MCTP CCI.

Please correct my understanding if this is incorrect.

Regarding the visibility problem, I intend to move the enum defining all the
opcodes in cxl-mailbox.utils.c to cxl-mailbox.h and including cxl-mailbox.h
in i2c_mctp_cxl.c

Let me know if that is what you intended.

Other than that, I have removed the extraneous TO-DO's from the other
patches and plan to send out v2 with relevant corrections soon.
Hopefully that makes the remaining patches easier for you to review.

Thanks,
Anisa

 
> 
> 
> >              buf->rc = CXL_MBOX_UNSUPPORTED;
> >              st24_le_p(buf->pl_length, len_out);
> >              s->len = s->pos;
> 
